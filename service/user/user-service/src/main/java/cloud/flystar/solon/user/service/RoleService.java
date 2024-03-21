package cloud.flystar.solon.user.service;

import cloud.flystar.solon.core.service.IBaseService;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.service.entity.Role;

import javax.validation.constraints.NotNull;
import java.util.List;


public interface RoleService extends IBaseService<Role> {
    List<Role> listUserEnableRole(@NotNull Long userId);
    List<RoleDto> listUserEnableRoleDto(@NotNull Long userId);

}
