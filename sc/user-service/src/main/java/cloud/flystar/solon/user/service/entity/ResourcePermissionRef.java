package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限表
 */
@Data
public class ResourcePermissionRef {
   private Long id;
   private String permissionId;
   private String resourceType;
   private Long resourceId;

    private LocalDateTime createTime;
    private Long createUserId;

}
