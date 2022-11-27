package cloud.flystar.solon.user.service;

import cloud.flystar.solon.framework.service.IBaseService;
import cloud.flystar.solon.user.service.entity.Department;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author: pangyannan
 */
public interface DepartmentService  extends IBaseService<Department> {
    /**
     * 当前用户的部门
     * @param userId
     * @return
     */
    List<Department> listUserDepartment(@NotNull Long userId);

    /**
     * 查询所有子节点
     * @param deptId
     * @return
     */
    List<Department> listByParentId(@NotNull Long deptId);

}
