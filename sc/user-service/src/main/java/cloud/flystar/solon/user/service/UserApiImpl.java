package cloud.flystar.solon.user.service;

import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.PermissionDto;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.api.dto.UserDto;
import cloud.flystar.solon.user.service.convert.UserDtoConvert;
import cloud.flystar.solon.user.service.entity.UserInfo;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.lang.Assert;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Validated
public class UserApiImpl implements UserApi {
    @Resource
    private UserInfoService userInfoService;
    @Resource
    private UserDtoConvert userDtoConvert;
    @Resource
    private RoleService roleService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private ResourceInfoService resourceInfoService;

    @Override
    public UserDto getById(@NotNull Long userId) {
        UserInfo userInfo = userInfoService.getById(userId);
        return userDtoConvert.doForward(userInfo);
    }

    @Override
    public List<UserDto> listByIds(@NotEmpty @Size(max = 1000) List<Long> userIds) {
        if(CollectionUtil.isEmpty(userIds)){
            return new ArrayList<>();
        }
        Set<Long> idSet = userIds.stream().collect(Collectors.toSet());
        List<UserInfo> userInfos = userInfoService.listByIds(idSet);
        return userDtoConvert.doForward(userInfos);
    }

    @Override
    public UserDto getByUserName(@NotBlank String userName) {
        List<UserInfo> list = userInfoService.lambdaQuery().eq(UserInfo::getUserName, userName).list();
        Assert.isTrue(CollectionUtil.size(list) <= 1,"userName={} find multiple UserInfo",userName);
        return userDtoConvert.doForward(list.get(0));
    }

    @Override
    public List<RoleDto> listUserEnableRole(@NotNull Long userId) {
        return roleService.listUserEnableRoleDto(userId);
    }

    @Override
    public List<PermissionDto> listUserPermission(@NotNull Long userId) {
        return permissionService.listUserPermissionDto(userId);
    }

    @Override
    public List<ResourceInfoDto> listUserResource(@NotNull Long userId, String resourceType) {
        return resourceInfoService.listUserResourceDto(userId,resourceType);
    }
}
