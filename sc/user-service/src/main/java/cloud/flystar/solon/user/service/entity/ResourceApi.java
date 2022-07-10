package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * app资源
 */
@Data
public class ResourceApi {
    private Long resourceId;
    /**
     * 接口资源路径，一般是api路径
     */
    private String resourceCode;
    /**
     * api名称
     */
    private String resourceName;

    /**
     * 备注
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
