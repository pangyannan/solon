package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户角色
 */
@Data
public class UserRoleRef {
    private Integer id;
    /** 用户ID */
    private Long userId;
    /** 角色ID */
    private Long roleId;

    private LocalDateTime createTime;
    private Long createUserId;
}
