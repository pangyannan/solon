package cloud.flystar.solon.user.api;

import cloud.flystar.solon.user.api.dto.PermissionDto;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.api.dto.UserDto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * 用户服务API
 * 用于向其他模块提供服务
 */
public interface UserApi {
    /**
     * 根据userId查询用户
     * @param userId
     * @return
     */
    UserDto getById(@NotNull Long userId);

    /**
     * 根据userId集合查询用户集合
     * @param userIds
     * @return
     */
    List<UserDto> listByIds(@NotEmpty @Size(max = 1000) List<Long> userIds);

    /**
     * 根据userName查询用户
     * @param userName
     * @return
     */
    UserDto getByUserName(@NotBlank String userName);

    /**
     * 根据userId查询用户可用角色
     * @param userId
     * @return
     */
    List<RoleDto> listUserEnableRole(@NotNull Long userId);

    /**
     * 根据userId查询用户权限
     * @param userId
     * @return
     */
    List<PermissionDto> listUserPermission(@NotNull Long userId);

    /**
     * 根据userId查询用户资源
     * @param userId
     * @param resourceType
     * @param projectCode
     * @return
     */
    List<ResourceInfoDto> listUserResource(@NotNull Long userId,String resourceType,String projectCode);
}
