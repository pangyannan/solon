package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * app资源
 */
@Data
public class ResourceApp {
    private Long resourceId;
    /**
     * 应用编码
     */
    private String resourceCode;
    /**
     * 应用名称
     */
    private String resourceName;

    /**
     * 说明
     */
    private String remarks;

    /**
     * 状态 0禁用 1启用
     */
    private Integer status;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
