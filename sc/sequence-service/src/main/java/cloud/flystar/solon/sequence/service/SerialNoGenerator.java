package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.sequence.service.bo.*;
import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.RandomUtil;
import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import com.google.common.base.Stopwatch;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.checkerframework.checker.nullness.qual.NonNull;
import org.checkerframework.checker.nullness.qual.Nullable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

/**
 * 流水号生成器核心入口服务
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class SerialNoGenerator {
    //每个segment的剩余空闲ID比例阈值,当空闲ID小于该比例时,则异步加载下一段
    private static final double IdleFreePercent = 0.8;
    private final SequenceSegmentService sequenceSegmentService;
    private final SequenceConfigService sequenceConfigService;
    @Qualifier("ioExecutor")
    private final ThreadPoolTaskExecutor ioExecutor;
    private Map<SegmentKey, SegmentBuffer> cache = new ConcurrentHashMap<>();

    //配置对象缓存，缓存时间为1个小时
    private LoadingCache<String, SequenceConfigBo> configCache = Caffeine.newBuilder()
            .maximumSize(1024)
            .expireAfterWrite(1L, TimeUnit.HOURS)
            .build(new CacheLoader<String, SequenceConfigBo>() {
                @Override
                public @Nullable SequenceConfigBo load(@NonNull String bizCode) {
                    SequenceConfigEntity sequenceConfigEntity = sequenceConfigService.getByBizCode(bizCode);
                    SequenceConfigBo sequenceConfigBo = new SequenceConfigBo();
                    sequenceConfigBo.setSequenceConfigEntity(sequenceConfigEntity);
                    return sequenceConfigBo;
                }
            });


    /**
     * 核心入口方法：获取序列号
     * @param bizCode 业务类型编码
     * @return 序列号
     */
    public String getSerialNo(final String bizCode) throws Exception {
        //1.获取当前业务+循环主键
        SegmentKey segmentKey = this.getSegmentKey(bizCode);

        //2.SegmentBuffer初始化
        SegmentBuffer buffer = cache.get(segmentKey);
        if (Objects.isNull(buffer)) {
            synchronized (this) {
                buffer = cache.get(segmentKey);
                if (Objects.isNull(buffer)) {
                    buffer = new SegmentBuffer(segmentKey, configCache.get(bizCode));
                    updateSegmentFromDb(segmentKey, buffer.getCurrent());
                    cache.put(segmentKey, buffer);
                }
            }
        }

        //3.生成流水号
        long segmentSeq = this.getSerialNoFromSegmentBuffer(buffer);


        //4.格式化拼接
        SequenceConfigEntity sequenceConfigEntity = buffer.getSequenceConfigBo().getSequenceConfigEntity();
        StringBuilder sb = new StringBuilder()
                .append(sequenceConfigEntity.getSeqPrefix())
                .append(segmentKey.getLoopKey());

        if(StringUtils.isNotBlank(sequenceConfigEntity.getLoopNumberFormat())){
            DecimalFormat decimalFormat = new DecimalFormat(sequenceConfigEntity.getLoopNumberFormat());
            sb.append(decimalFormat.format(segmentSeq));
        }else{
            sb.append(segmentSeq);
        }

        return sb.toString();
    }

    /**
     * 从DB获取数据更新segment
     * 1.全局分布式锁
     * @param key 唯一键
     * @param segment segment
     */
    private void updateSegmentFromDb(SegmentKey key, Segment segment) throws Exception {
        Stopwatch sw = Stopwatch.createStarted();
        SegmentBuffer segmentBuffer = segment.getSegmentBuffer();
        PsmSerialNoRecord record;
        if (segmentBuffer.getUpdateTimestamp() == 0) {
            record = psmSerialNoRecordService.modifyMaxIdAndGet(key, SegmentBuffer.MIN_STEP, SERIAL_NO_LIMIT);
            segmentBuffer.setUpdateTimestamp(System.currentTimeMillis());
            segmentBuffer.setStep(SegmentBuffer.MIN_STEP);
        } else {
            long duration = System.currentTimeMillis() - segmentBuffer.getUpdateTimestamp();
            int nextStep = segmentBuffer.getStep();
            if (duration < SEGMENT_DURATION) {
                if (nextStep << 1 > SegmentBuffer.MAX_STEP) {
                    // do nothing
                } else {
                    nextStep = nextStep << 1;
                }
            } else if (duration < SEGMENT_DURATION << 1) {
                // do nothing with nextStep
            } else {
                nextStep = nextStep >> 1 >= SegmentBuffer.MIN_STEP ? nextStep >> 1 : nextStep;
            }
            log.info("SerialNoGenerator updateSegmentFromDb key:{}, step:{}, duration:{}min, nextStep{}", key, segmentBuffer.getStep(), String.format("%.2f", ((double) duration / (1000 * 60))), nextStep);
            record = psmSerialNoRecordService.modifyMaxIdAndGet(key, nextStep, SERIAL_NO_LIMIT);
            segmentBuffer.setUpdateTimestamp(System.currentTimeMillis());
            segmentBuffer.setStep(nextStep);
        }
        long value = SERIAL_NO_LIMIT != record.getMaxId() ? record.getMaxId() - segmentBuffer.getStep() + 1 : segmentBuffer.getCurrent().getMax() + 1;
        segment.getValue().set(value);
        segment.setMax(record.getMaxId());
        segment.setStep(segmentBuffer.getStep());
        log.info("SerialNoGenerator updateSegmentFromDb 数据库更新耗时:{}", sw.stop().elapsed(TimeUnit.MILLISECONDS));
    }

    /**
     * @description: 从buffer中获取序列号
     *
     * @param buffer buffer
     * @return long
     */
    private long getSerialNoFromSegmentBuffer(final SegmentBuffer buffer) throws Exception {
        while (true) {
            log.trace("获取序列号:SegmentBuffer=[{}]",buffer);
            buffer.rLock().lock();
            try {
                final Segment segment = buffer.getCurrent();
                // 如果是不可切换状态 && 空闲数量 < 最小空闲比例数量 && 如果线程状态是没有运行，则将状态设置为运行状态
                if (!buffer.isNextReady()
                        && (segment.getIdle() < IdleFreePercent * segment.getStep())
                        && buffer.getThreadRunning().compareAndSet(false, true)) {

                    //启动线程加载nextSegment
                    ioExecutor.execute(() -> {
                        Segment nextSegment = buffer.getSegments()[buffer.nextPos()];
                        // 数据是否加载完毕，默认false
                        boolean updateOk = false;
                        try {
                            updateSegmentFromDb(buffer.getKey(), nextSegment);
                            updateOk = true;
                            log.info("SerialNoGenerator getIdFromSegmentBuffer key:{}，更新segment:{}", buffer.getKey(), nextSegment);
                        } catch (Exception e) {
                            log.error("SerialNoGenerator getIdFromSegmentBuffer key:{}，更新segment异常:{}", buffer.getKey(), e.getMessage(), e);
                        } finally {
                            if (updateOk) {
                                buffer.wLock().lock();
                                buffer.setNextReady(true);
                                buffer.getThreadRunning().set(false);
                                buffer.wLock().unlock();
                            } else {
                                buffer.getThreadRunning().set(false);
                            }
                        }
                    });
                }

                long value = this.segmentGetAndIncrementAndCheck(segment);
                if(value >= 0){
                    return value;
                }
            } finally {
                buffer.rLock().unlock();
            }
            // 如果上面当前段没有拿到序列号，说明当前段序列用完了，需要切换，下一段是在线程池中运行的，所以这里等待一小会儿
            waitAndSleep(buffer);

            buffer.wLock().lock();
            try {
                // 再次拿当前段，因为有可能前面一个线程已经切换好了
                final Segment segment = buffer.getCurrent();
                long value = this.segmentGetAndIncrementAndCheck(segment);
                if(value >= 0){
                    return value;
                }

                // 如果是处于可以切换状态，就切换段并设置为不可切换状态，下次获取时就可以在线程池中加载下一段
                if (buffer.isNextReady()) {
                    buffer.switchPos();
                    buffer.setNextReady(false);
                } else {
                    log.error("SerialNoGenerator getIdFromSegmentBuffer 两个Segment都未从数据库中加载 buffer:{}!", buffer);
                    throw new Exception("SerialNoGenerator getIdFromSegmentBuffer 两个Segment都未从数据库中加载");
                }
            } finally {
                buffer.wLock().unlock();
            }
        }
    }

    /**
     * 从segment获取自增数并检查是否符合条件  如果没有获取到符合条件的则返回-1
     */
    private long segmentGetAndIncrementAndCheck(final Segment segment){
        //自增步长
        long nextNumberRandomMin = segment.getSegmentBuffer().getSequenceConfigBo().getSequenceConfigEntity().getNextNumberRandomMin().longValue();
        long nextNumberRandomMax = segment.getSegmentBuffer().getSequenceConfigBo().getSequenceConfigEntity().getNextNumberRandomMax().longValue();
        long randomInt;
        if(nextNumberRandomMin == nextNumberRandomMax){
            randomInt = nextNumberRandomMin;
        }else{
            randomInt = RandomUtil.randomLong(nextNumberRandomMin, nextNumberRandomMax);
        }

        long value = segment.getValue().getAndAdd(randomInt);

        //应该在segment创建的时候判断，没有必要每次判断浪费CPU
//        long loopNumberMax = segment.getSegmentBuffer().getSequenceConfigBo().getSequenceConfigEntity().getLoopNumberMax().longValue();
//        if(loopNumberMax > 0L & value > loopNumberMax){
//            throw new IllegalStateException(String.format("the value=[%s] is greater than LoopNumberMax=[%s]",value,loopNumberMax));
//        }

        if (value <= segment.getMax()) {
            return value;
        }
//        throw new IllegalStateException(String.format("the value=[%s] is greater than segmentMax=[%s]",value, segment.getMax()));
        return -1L;
    }


    /**
     * 等待下一段加载完成
     */
    private void waitAndSleep(SegmentBuffer segmentBuffer) {
        int roll = 0;
        while (segmentBuffer.getThreadRunning().get()) {
            roll += 1;
            if (roll > 100) {
                try {
                    TimeUnit.MILLISECONDS.sleep(10);
                    break;
                } catch (InterruptedException e) {
                    log.error("SerialNoGenerator waitAndSleep 线程睡眠异常，Thread:{}, 异常:{}", Thread.currentThread().getName(), e);
                    break;
                }
            }
        }
    }


    /**
     * 获取当前业务类型的流水号段主键
     */
    private SegmentKey getSegmentKey(String bizCode){
        SequenceConfigBo sequenceConfigBo = configCache.get(bizCode);
        Assert.isTrue(Objects.nonNull(sequenceConfigBo),"bizCode=[{}] is not exist",bizCode);
        String loopKey = this.getLoopKey(sequenceConfigBo.getSequenceConfigEntity());
        if(sequenceConfigBo.getCurrentSegmentKey() != null && StringUtils.equals(sequenceConfigBo.getCurrentSegmentKey().getLoopKey(),loopKey)){
            return sequenceConfigBo.getCurrentSegmentKey();
        }
        //没有必要进行并发控制创建
        SegmentKey segmentKey = new SegmentKey(sequenceConfigBo.getSequenceConfigEntity().getBizCode(), loopKey);
        sequenceConfigBo.setCurrentSegmentKey(segmentKey);
        return segmentKey;
    }

    /**
     * 根据配置获取循环主键
     * @param sequenceConfigEntity
     * @return
     */
    private String getLoopKey(SequenceConfigEntity sequenceConfigEntity){
        SequenceConfigLoopTypeEnum sequenceConfigLoopTypeEnum = SequenceConfigLoopTypeEnum.getByCode(sequenceConfigEntity.getLoopCode());
        String lookKey = StringUtils.EMPTY;
        switch (sequenceConfigLoopTypeEnum){
            case NONE:{
                lookKey = StringUtils.EMPTY;
                break;
            }
            case DATE:{
                lookKey = DateFormatUtils.format(new Date(),lookKey);
                break;
            }
            default:
                throw new IllegalArgumentException(String.format("LoopType=[%s] is not have value function",sequenceConfigLoopTypeEnum));
        }
        return lookKey;
    }

    
}
