package cloud.flystar.solon.user.service.entity;


import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 部门表
 * 根部门ID为0，并且不能定义dept0的部门
 */
@Data
@TableName("department")
public class Department {
    /** 部门ID */
    @TableId(type = IdType.ASSIGN_ID)
    private Long deptId;

    /** 部门名称 */
    private String deptName;

    /** 父部门ID*/
    private Long parentDeptId;

    /**
     * 所有父部门ID路径，从根路径开始，逗号分割 比如  0,9,20,301
     * 不包含自己
     */
    private String parentDeptIdPath;


    /** 部门编码，一般与其他系统关联使用 */
    private String deptSourceCode;

    /** 部门状态（0停用 1正常）*/
    private Integer enableFlag;

    /** 删除标志（0代表未删除 1代表删除）*/
    @TableLogic
    private Integer deleteFlag;

    /** 显示顺序 */
    private Integer sortNum;

    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;
}
