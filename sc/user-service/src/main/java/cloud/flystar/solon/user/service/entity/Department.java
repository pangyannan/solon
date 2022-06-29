package cloud.flystar.solon.user.service.entity;


import lombok.Data;

import java.time.LocalDateTime;

/**
 * 部门表
 */
@Data
public class Department {
    /** 部门ID */
    private Long deptId;

    /** 部门名称 */
    private String deptName;

    /** 显示顺序 */
    private Integer orderNum;

    /** 父部门ID */
    private String parentId;

    /** 父部门名称 */
    private String parentName;

    /** 所有父部门ID列表 */
    private String parentIds;

    /** 所有父部门名称,以/分割，例如 信息科技部/研发中心组 */
    private String parentsName;

    /** 部门编码，一般与其他系统关联使用 */
    private String deptCode;

    /** 部门状态:0正常,1停用 */
    private String status;

    private LocalDateTime createTime;
    private String createBy;
    private LocalDateTime updateTime;
    private String updateBy;
}
