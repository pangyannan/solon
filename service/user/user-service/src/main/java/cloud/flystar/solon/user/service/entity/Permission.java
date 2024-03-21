package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 权限表
 * 一般一个权限小组是以一个功能领域为核心
 */
@Data
@TableName("permission")
public class Permission {

    @TableId(type = IdType.ASSIGN_ID)
    private Long permissionId;
    private String permissionName;
    private String remark;


    /** 状态（0停用 1正常）*/
    private Integer enableFlag;

    /** 删除标志（0代表未删除 1代表删除）*/
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
