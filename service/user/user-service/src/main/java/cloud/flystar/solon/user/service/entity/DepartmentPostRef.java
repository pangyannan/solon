package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 部门岗位关联表
 */
@Data
@TableName("department_post_ref")
public class DepartmentPostRef {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    /** 部门ID */
    private Long deptId;
    /** 岗位ID */
    private Long postId;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
}
