package cloud.flystar.solon.sequence.service.dao.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 流水号分段记录表
 */
@Data
public class SequenceSegmentEntity {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    private Long configId;
    private String loopTime;
    private Long segmentMax;
    private Long version;
    private LocalDateTime updateTime;
}
