package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限表
 */
@Data
public class PermissionResourceRef {
    private Long id;
    private Long permissionId;
    private Long resourceId;
    private String resourceType;

    private LocalDateTime createTime;
    private Long createUserId;

}
