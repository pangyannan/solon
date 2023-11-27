package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.framework.config.pool.ThreadPoolHolder;
import cloud.flystar.solon.sequence.service.bo.*;
import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import cloud.flystar.solon.sequence.service.dao.po.SequenceSegmentEntity;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.RandomUtil;
import com.github.benmanes.caffeine.cache.CacheLoader;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.checkerframework.checker.nullness.qual.NonNull;
import org.checkerframework.checker.nullness.qual.Nullable;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Component;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * 流水号生成器核心入口服务
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class SerialNoGenerator {
    //每个segment的剩余空闲ID比例阈值,当空闲ID小于该比例时,则异步加载下一段
    private  static final double idleFreePercent = 0.8D;
    private  final int cacheSize = 1024;
    //    private static final Map<SegmentKey, SegmentBuffer> cache = new ConcurrentHashMap<>();

    private final SequenceSegmentService sequenceSegmentService;
    private final SequenceConfigService sequenceConfigService;
    private final RedissonClient redissonClient;

    //配置对象缓存，缓存时间为1个小时
    private final LoadingCache<String, SequenceConfigBo> configCache = Caffeine.newBuilder()
            .executor(ThreadPoolHolder.ioExecutor())
            .maximumSize(cacheSize)
            .expireAfterWrite(1L, TimeUnit.HOURS)
            .build(new CacheLoader<String, SequenceConfigBo>() {
                @Override
                public @Nullable SequenceConfigBo load(@NonNull String bizCode) {
                    SequenceConfigEntity sequenceConfigEntity = sequenceConfigService.getByBizCode(bizCode);
                    if(sequenceConfigEntity != null){
                        SequenceConfigBo sequenceConfigBo = new SequenceConfigBo();
                        sequenceConfigBo.setSequenceConfigEntity(sequenceConfigEntity);
                        return sequenceConfigBo;
                    }
                    return null;
                }
            });

    //配置对象缓存，缓存时间为1个小时
    private final LoadingCache<SegmentKey, SegmentBuffer> cache = Caffeine.newBuilder()
            .executor(ThreadPoolHolder.ioExecutor())
            .maximumSize(cacheSize * 2)
            .expireAfterAccess(24L, TimeUnit.HOURS)
            .build(segmentKey -> {
                SegmentBuffer buffer = new SegmentBuffer(segmentKey, configCache.get(segmentKey.getBizCode()));
                updateSegmentFromDb(segmentKey, buffer.getCurrent());
                return buffer;
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
    private void updateSegmentFromDb(SegmentKey key, Segment segment)  {

        SegmentBuffer segmentBuffer = segment.getSegmentBuffer();
        SequenceConfigEntity sequenceConfigEntity = segmentBuffer.getSequenceConfigBo().getSequenceConfigEntity();
        long loopSegmentStep = Long.valueOf(sequenceConfigEntity.getLoopSegmentStep());
        long loopNumberMax = sequenceConfigEntity.getLoopNumberMax() < 0 ? Long.MAX_VALUE : sequenceConfigEntity.getLoopNumberMax();
        RLock lock = redissonClient.getLock(this.getClass().getName() + ":updateSegmentFromDb" + ":" + key.getBizCode() + ":" + key.getLoopKey());
        try {
            boolean tryLock = lock.tryLock(1000, 5000, TimeUnit.MILLISECONDS);
            if(!tryLock){
                throw  new RuntimeException("序列号生成异常");
            }

            long value;
            SequenceSegmentEntity sequenceSegmentEntity = sequenceSegmentService.selectByBizAndLoop(key.getBizCode(), key.getLoopKey());
            if(sequenceSegmentEntity == null){
                value = sequenceConfigEntity.getLoopNumberMin();

                sequenceSegmentEntity = new SequenceSegmentEntity();
                sequenceSegmentEntity.setBizCode(key.getBizCode());
                sequenceSegmentEntity.setLoopCode(key.getLoopKey());
                sequenceSegmentEntity.setMaxId(loopSegmentStep);
                sequenceSegmentEntity.setVersion(0L);

                Assert.isTrue( sequenceSegmentEntity.getMaxId() < loopNumberMax, "segment maxId {} is gl loopNumberMax {}", sequenceSegmentEntity.getMaxId(), loopNumberMax);
                sequenceSegmentService.save(sequenceSegmentEntity);

            }else{
                value = sequenceSegmentEntity.getMaxId() + 1L;

                sequenceSegmentEntity.setMaxId(sequenceSegmentEntity.getMaxId() + loopSegmentStep);
                sequenceSegmentEntity.setVersion(sequenceSegmentEntity.getVersion() + 1L);

                Assert.isTrue( sequenceSegmentEntity.getMaxId() < loopNumberMax, "segment maxId {} is gl loopNumberMax {}", sequenceSegmentEntity.getMaxId(), loopNumberMax);
                sequenceSegmentService.updateById(sequenceSegmentEntity);
            }


            long currentTimeMillis = System.currentTimeMillis();
            segmentBuffer.setUpdateTimestamp(currentTimeMillis);

            segment.getValue().set(value);
            segment.setMax(sequenceSegmentEntity.getMaxId());
            segment.setStep(loopSegmentStep);
            segment.setCreateTimestamp(currentTimeMillis);


        } catch (InterruptedException e) {
            log.error("锁异常",e);
            throw  new RuntimeException("序列号生成异常");
        }finally {
            lock.unlock();
        }

    }

    /**
     * 从buffer中获取序列号
     */
    private long getSerialNoFromSegmentBuffer(final SegmentBuffer buffer) throws Exception {
        while (true) {
            log.trace("获取序列号:SegmentBuffer=[{}]",buffer);
            buffer.rLock().lock();
            try {
                final Segment segment = buffer.getCurrent();
                // 如果是不可切换状态 && 空闲数量 < 最小空闲比例数量 && 如果线程状态是没有运行，则将状态设置为运行状态
                if (!buffer.isNextReady()
                        && (segment.getIdle() < idleFreePercent * segment.getStep())
                        && buffer.getThreadRunning().compareAndSet(false, true)) {

                    //启动线程加载nextSegment
                    ThreadPoolHolder.ioExecutor().execute(() -> {
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
                                buffer.setNextReady(false);
                                buffer.getThreadRunning().set(false);
                            }
                        }
                    });
                }

                long value = this.segmentGetAndIncrementAndCheck(segment);
                if(value >= 0){
                    this.checkSegmentDuration(buffer, segment);
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
                    this.checkSegmentDuration(buffer, segment);
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
        long nextNumberRandomMin = segment.getSegmentBuffer().getSequenceConfigBo().getSequenceConfigEntity().getNextNumberRandomMin();
        long nextNumberRandomMax = segment.getSegmentBuffer().getSequenceConfigBo().getSequenceConfigEntity().getNextNumberRandomMax();
        long randomInt;
        if(nextNumberRandomMin == nextNumberRandomMax){
            randomInt = nextNumberRandomMin;
        }else{
            randomInt = RandomUtil.randomLong(nextNumberRandomMin, nextNumberRandomMax);
        }

        long value = segment.getValue().getAndAdd(randomInt);

        if (value <= segment.getMax()) {
            return value;
        }
        return -1L;
    }


    private void checkSegmentDuration(final SegmentBuffer buffer, final Segment segment){
        Integer loopSegmentDurationSecond = buffer.getSequenceConfigBo().getSequenceConfigEntity().getLoopSegmentDurationSecond();
        if(loopSegmentDurationSecond <= 0){
            return;
        }

        //判断当前时间与segment的创建时间是否超过期限
        long createTimestamp = segment.getCreateTimestamp();
        long currentTimeMillis = System.currentTimeMillis();
        if((currentTimeMillis - createTimestamp)/1000 > loopSegmentDurationSecond){
            //需切换
            if (buffer.isNextReady()) {
                buffer.switchPos();
                buffer.setNextReady(false);
            }
        }

    }

    /**
     * 等待下一段加载完成
     */
    private void waitAndSleep(SegmentBuffer segmentBuffer) {
        int roll = 0;
        int max = 1000 * 10;
        while (roll <= max && segmentBuffer.getThreadRunning().compareAndSet(true,true)) {
            roll += 1;
            if (roll > 1000) {
                try {
                    TimeUnit.MILLISECONDS.sleep(10);
                } catch (InterruptedException e) {
                    log.error("SerialNoGenerator waitAndSleep 线程睡眠异常，Thread:{}, 异常:{}", Thread.currentThread().getName(), e);
                    break;
                }
            }
        }
        if(roll > max){
            log.error("未能等待Segment加载完毕");
        }
    }


    /**
     * 获取当前业务类型的流水号段主键
     */
    private SegmentKey getSegmentKey(String bizCode){
        SequenceConfigBo sequenceConfigBo = configCache.get(bizCode);
        Assert.isTrue(Objects.nonNull(sequenceConfigBo),"bizCode=[{}] is not exist",bizCode);
        String loopKey = this.getLoopKey(sequenceConfigBo.getSequenceConfigEntity());
        SegmentKey currentSegmentKey = sequenceConfigBo.getCurrentSegmentKey();
        if(currentSegmentKey != null && StringUtils.equals(currentSegmentKey.getLoopKey(),loopKey)){
            return currentSegmentKey;
        }
        SegmentKey segmentKeyNew = new SegmentKey(sequenceConfigBo.getSequenceConfigEntity().getBizCode(), loopKey);
        sequenceConfigBo.setCurrentSegmentKey(segmentKeyNew);
        return segmentKeyNew;
    }

    /**
     * 根据配置获取循环主键
     */
    private String getLoopKey(SequenceConfigEntity sequenceConfigEntity){
        SequenceConfigLoopTypeEnum sequenceConfigLoopTypeEnum = SequenceConfigLoopTypeEnum.getByCode(sequenceConfigEntity.getLoopType());
        String lookKey;
        switch (sequenceConfigLoopTypeEnum){
            case NONE:{
                lookKey = StringUtils.EMPTY;
                break;
            }
            case DATE:{
                lookKey = DateFormatUtils.format(new Date(),sequenceConfigEntity.getLoopCode());
                break;
            }
            default:
                throw new IllegalArgumentException(String.format("LoopType=[%s] is not have value function",sequenceConfigLoopTypeEnum));
        }
        return lookKey;
    }

    
}
