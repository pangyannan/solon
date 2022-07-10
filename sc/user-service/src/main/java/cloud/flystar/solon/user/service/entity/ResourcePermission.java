package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限表
 */
@Data
public class ResourcePermission {
   private Long permissionId;
   private String permissionCode;
   private String permissionName;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
