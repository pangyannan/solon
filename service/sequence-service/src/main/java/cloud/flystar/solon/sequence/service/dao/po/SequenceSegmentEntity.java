package cloud.flystar.solon.sequence.service.dao.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 流水号分段ID记录表
 */
@Data
@TableName("sequence_segment")
public class SequenceSegmentEntity {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    private String bizCode;
    private String loopCode;
    private Long maxId;
    private Long version;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
}
