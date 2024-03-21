package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限资源关系表
 */
@Data
@TableName("permission_resource_ref")
public class PermissionResourceRef {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;
    private Long permissionId;
    private Long resourceId;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;

}
