package cloud.flystar.solon.sequence.service.bo;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;


/**
 * Segment主键
 */
public class SegmentKey {
    private final String bizCode;
    private final String loopKey;



    public SegmentKey(String bizCode, String loopKey) {
        this.bizCode = bizCode;
        this.loopKey = loopKey;
    }

    public String getBizCode() {
        return bizCode;
    }

    public String getLoopKey() {
        return loopKey;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SegmentKey that = (SegmentKey) o;
        return new EqualsBuilder().append(bizCode, that.bizCode).append(loopKey, that.loopKey).isEquals();
    }
    @Override
    public int hashCode() {
        return new HashCodeBuilder(17, 37).append(bizCode).append(loopKey).toHashCode();
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this)
                .append("bizCode", bizCode)
                .append("loopKey", loopKey)
                .toString();
    }
}
