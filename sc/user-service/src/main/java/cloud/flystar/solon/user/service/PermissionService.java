package cloud.flystar.solon.user.service;

import cloud.flystar.solon.framework.service.IBaseService;
import cloud.flystar.solon.user.api.dto.PermissionDto;
import cloud.flystar.solon.user.service.entity.Permission;

import javax.validation.constraints.NotNull;
import java.util.List;

public interface PermissionService extends IBaseService<Permission> {
    List<Permission> listUserPermission(@NotNull Long userId);

    List<PermissionDto> listUserPermissionDto(@NotNull Long userId);
}
