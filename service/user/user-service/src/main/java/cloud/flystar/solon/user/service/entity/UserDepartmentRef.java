package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 *部门人员关系
 */
@Data
@TableName("user_department_ref")
public class UserDepartmentRef {
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /** 用户ID */
    private Long userId;

    /** 部门ID */
    private Long deptId;

    /** 岗位ID */
    private Long postId;
    /**
     * 关系类型
     * @see cloud.flystar.solon.user.api.dto.UserDepartmentTypeEnum
     */
    private String refType;
    /**
     * 是否是主要部门；
     * 0否 , 1是   默认1
     * @see cloud.flystar.solon.commons.bean.constant.YesOrNo
     */
    private Integer primaryFlag;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;
}
