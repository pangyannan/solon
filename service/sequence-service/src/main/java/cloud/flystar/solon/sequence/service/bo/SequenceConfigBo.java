package cloud.flystar.solon.sequence.service.bo;

import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import lombok.Data;

/**
 * 流水号配置表领域类
 */
@Data
public class SequenceConfigBo {
    private SequenceConfigEntity sequenceConfigEntity;
    private volatile SegmentKey currentSegmentKey;
}
