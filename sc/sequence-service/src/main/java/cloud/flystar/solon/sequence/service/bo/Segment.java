package cloud.flystar.solon.sequence.service.bo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.apache.commons.lang3.builder.ToStringBuilder;

import java.util.concurrent.atomic.AtomicLong;

/**
 * TODO
 *
 * @author: pangyannan
 */
@Getter
@Setter
public class Segment {
    private SegmentKey segmentKey;
    /**
     * 自增值
     */
    private AtomicLong value = new AtomicLong(1);

    /**
     * 当前段的最大值
     */
    private volatile long max;

    /**
     * 步长
     */
    public volatile long step;

    /**
     * 创建时间
     */
    private volatile long createTimestamp;

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
        return new ToStringBuilder(this)
                .append("segmentKey", segmentKey)
                .append("value", value)
                .append("max", max)
                .append("step", step)
                .toString();
    }

}
