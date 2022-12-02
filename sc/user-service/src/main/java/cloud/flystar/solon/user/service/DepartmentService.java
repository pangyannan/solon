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
     * 用户的部门
     * @param userId
     * @return
     */
    List<Department> listUserDepartment(@NotNull Long userId);

    /**
     * 用户管理的部门
     * @param userId
     * @return
     */
    List<Department> listUserManagerDepartment(@NotNull Long userId);

    /**
     * 查询子部门,不包含自己
     * @param deptId
     * @return
     */
    List<Department> listAllChildren(@NotNull Long deptId);


}
