package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 角色
 */
@Data
@TableName("role")
public class Role {

    /** 角色ID */
    @TableId(type = IdType.ASSIGN_ID)
    private Long roleId;

    /** 角色名称 */
    private String roleName;

    /** 状态（0停用 1正常）*/
    private Integer enableFlag;

    /** 删除标志（0代表未删除 1代表删除）*/
    @TableLogic
    private Integer deleteFlag;

    /**
     * 在实际业务中，很多时候的控制不一定来源与角色，还可能来源与部门、岗位等
     * 为了统一抽象为角色，这里设计其他可能的人员分组自动同步转换为角色，并自动赋值为角色
     * 角色类型
     */
    private String roleSourceType;
    /**
     * 外部来源ID
     */
    private String roleSourceId;



    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;
}
