package cloud.flystar.solon.user.service.entity;

import cloud.flystar.solon.commons.constant.UserResourceTypeEnum;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 页面元素资源
 */
@Data
public class ResourceInfo {
    private Long resourceId;

    /**
     * 系统编码
     */
    private String projectCode;

    /**
     * @see UserResourceTypeEnum
     * application 用户应用
     * menu 菜单
     * element 页面元素
     * api 接口资源
     */
    private String resourceType;

    /**
     * 资源标识
     * 最好是遵循资源路径模式
     * 例如：
     * 应用：
     *    后台管理系统 /admin
     *    移动端：/wechatApp
     * 菜单：
     *    一级菜单：/admin/system
     *    二级菜单：/admin/system/user
     * 元素：
     *    用户查询：/admin/system/user/list
     *    用户新增：/admin/system/user/add
     * api接口：
     *    /api/user/list
     *    /api/user/add
     *    /api/user/delete
     */
    private String resourceCode;
    /**
     * 资源名称
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
