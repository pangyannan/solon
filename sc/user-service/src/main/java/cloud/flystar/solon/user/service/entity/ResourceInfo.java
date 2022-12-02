package cloud.flystar.solon.user.service.entity;

import cloud.flystar.solon.commons.constant.UserResourceTypeEnum;
import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 页面元素资源
 */
@Data
@TableName("resource_info")
public class ResourceInfo {

    @TableId(type = IdType.ASSIGN_ID)
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

    /** 状态（0停用 1正常）*/
    private Integer enableFlag;

    @TableLogic
    private Integer deleteFlag;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;
}
