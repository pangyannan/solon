package cloud.flystar.solon.sequence.service.bo;

import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import lombok.Data;

import java.util.Arrays;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 *
 */
@Data
public class SegmentBuffer {

    /**
     * key,唯一值
     */
    private SegmentKey key;

    /**
     * 双buffer段数组，只有2段
     */
    private Segment[] segments;

    /**
     * 流水号配置
     */
    private SequenceConfigEntity sequenceConfigEntity;

    /**
     * 当前使用的segment的index
     */
    private volatile int currentPos;

    /**
     * 下一个segment是否处于可切换状态
     */
    private volatile boolean nextReady;

    /**
     * 线程是否在运行中
     */
    private final AtomicBoolean threadRunning;

    /**
     * 读写锁
     */
    private final ReadWriteLock lock;

    /**
     * 更新Segment时时间戳
     */
    private volatile long updateTimestamp;

    public SegmentBuffer(SegmentKey key) {
        this.key = key;
        segments = new Segment[]{new Segment(this), new Segment(this)};
        currentPos = 0;
        nextReady = false;
        threadRunning = new AtomicBoolean(false);
        lock = new ReentrantReadWriteLock();
    }

    /**
     * 获取当前的segment
     */
    public Segment getCurrent() {
        return segments[currentPos];
    }

    /**
     * 获取下一个segment
     */
    public int nextPos() {
        return (currentPos + 1) % 2;
    }

    /**
     * 切换segment
     */
    public void switchPos() {
        currentPos = nextPos();
    }

    /**
     * segmentBuffer加读锁
     */
    public Lock rLock() {
        return lock.readLock();
    }

    /**
     * segmentBuffer加写锁
     */
    public Lock wLock() {
        return lock.writeLock();
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("SegmentBuffer{");
        sb.append("key='").append(key);
        sb.append(", segments=").append(Arrays.toString(segments));
        sb.append(", currentPos=").append(currentPos);
        sb.append(", nextReady=").append(nextReady);
        sb.append(", threadRunning=").append(threadRunning);
        sb.append(", step=").append(this.getSequenceConfigEntity().getLoopSegmentStep());
        sb.append(", updateTimestamp=").append(updateTimestamp);
        sb.append('}');
        return sb.toString();
    }

}
