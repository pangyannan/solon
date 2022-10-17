package cloud.flystar.solon.user.api.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 角色
 */
@Data
public class RoleDto {
    /** 角色ID */
    private Long roleId;

    /** 角色名称 */
    private String roleName;

    /**
     * 角色类型
     */
    private String roleSourceType;
    /**
     * 外部来源ID，主要用户和其他系统对接用
     */
    private String roleSourceId;


    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
