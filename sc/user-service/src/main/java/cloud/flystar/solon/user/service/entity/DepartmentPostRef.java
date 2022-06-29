package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 部门岗位关联表
 */
@Data
public class DepartmentPostRef {
    private Long id;
    /** 部门ID */
    private Long deptId;
    /** 岗位ID */
    private Long postId;
    private LocalDateTime createTime;
}
