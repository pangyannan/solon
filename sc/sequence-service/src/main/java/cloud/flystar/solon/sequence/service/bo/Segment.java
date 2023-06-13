package cloud.flystar.solon.sequence.service.bo;

import lombok.Data;

import java.util.concurrent.atomic.AtomicLong;

/**
 * TODO
 *
 * @author: pangyannan
 */
@Data
public class Segment {
    private SegmentKey segmentKey;
    /**
     * 自增值
     */
    private AtomicLong value = new AtomicLong(0);

    /**
     * 当前段的最大值
     */
    private volatile long max;

    /**
     * 步长
     */
    public volatile long step;


    /**
     * buffer
     */
    private SegmentBuffer segmentBuffer;


    public Segment(SegmentBuffer segmentBuffer) {
        this.segmentBuffer = segmentBuffer;
    }

    /**
     * 获取空闲数
     * @return long 空闲数
     */
    public long getIdle() {
        return this.getMax() - this.getValue().get();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("Segment(");
        sb.append("value:");
        sb.append(value);
        sb.append(",max:");
        sb.append(max);
        sb.append(",step:");
        sb.append(segmentBuffer.getSequenceConfigEntity().getLoopSegmentStep());
        sb.append(")");
        return sb.toString();
    }

}
