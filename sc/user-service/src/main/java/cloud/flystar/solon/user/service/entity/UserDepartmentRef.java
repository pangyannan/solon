package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 *部门人员关系
 */
@Data
public class UserDepartmentRef {
    private Long id;
    /** 用户ID */
    private Long userId;
    /** 部门ID */
    private Long deptId;
    /** 岗位ID */
    private Long postId;
    /**
     * 关系类型
     * ORG: 员工组织所属
     * LEADER: 负责人
     */
    private String refType;


    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
