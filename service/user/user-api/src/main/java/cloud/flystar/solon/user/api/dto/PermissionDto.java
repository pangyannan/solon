package cloud.flystar.solon.user.api.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限
 */
@Data
public class PermissionDto {
   private Long permissionId;
   private String permissionName;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
