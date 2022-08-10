package cloud.flystar.solon.user.api.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 系统资源
 */
@Data
public class ResourceInfoDto {
    private Long resourceId;

    /**
     * app 应用
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


    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
