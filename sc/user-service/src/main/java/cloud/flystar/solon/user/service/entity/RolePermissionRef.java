package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 角色权限关联表
 */
@Data
public class RolePermissionRef {
    private Long id;
    private Long roleId;
    private Long permissionId;

    private LocalDateTime createTime;
    private Long createUserId;

}
