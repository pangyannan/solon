package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 页面元素资源
 */
@Data
public class ResourceMenu {
    private Long resourceId;
    /**
     * 应用ID
     */
    private String appResourceId;

    /**
     * 资源标识，同一个APP下是唯一的
     * 例如：
     * sys/user
     * sys/user/btn/add
     * sys/user/view/mobile
     */
    private String resourceCode;
    /**
     * 资源名称
     */
    private String resourceName;

    /**
     * 资源类型  1菜单 2操作
     */
    private Integer menuType;

    /**
     * 资源排序，一般用作菜单的排序
     */
    private Integer menuSort;

    /**
     * 图标
     */
    private String icon;

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
