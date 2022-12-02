package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.api.dto.PermissionDto;
import cloud.flystar.solon.user.service.PermissionService;
import cloud.flystar.solon.user.service.RoleService;
import cloud.flystar.solon.user.service.convert.PermissionDtoConvert;
import cloud.flystar.solon.user.service.entity.Permission;
import cloud.flystar.solon.user.service.entity.Role;
import cloud.flystar.solon.user.service.entity.RolePermissionRef;
import cloud.flystar.solon.user.service.mapper.PermissionMapper;
import cloud.flystar.solon.user.service.mapper.RolePermissionRefMapper;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import com.baomidou.mybatisplus.extension.toolkit.ChainWrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@Slf4j
@Service
@Validated
public class PermissionServiceImpl extends BaseServiceImpl<PermissionMapper, Permission> implements PermissionService {
    @Resource
    RolePermissionRefMapper rolePermissionRefMapper;
    @Resource
    RoleService roleService;
    @Resource
    PermissionDtoConvert permissionDtoConvert;

    @Override
    public List<Permission> listUserPermission(@NotNull Long userId) {
        List<Role> roleList = roleService.listUserEnableRole(userId);
        if(CollectionUtil.isEmpty(roleList)){
            return ListUtil.empty();
        }
        Set<Long> roleIds = roleList.stream().map(Role::getRoleId).collect(Collectors.toSet());

        List<RolePermissionRef> rolePermissionRefs = ChainWrappers.lambdaQueryChain(rolePermissionRefMapper).in(RolePermissionRef::getRoleId, roleIds).list();
        if(CollectionUtil.isEmpty(rolePermissionRefs)){
            return ListUtil.empty();
        }

        Set<Long> permissionIds = rolePermissionRefs.stream().map(RolePermissionRef::getPermissionId).collect(Collectors.toSet());
        return this.listByIds(permissionIds);
    }

    @Override
    public List<PermissionDto> listUserPermissionDto(@NotNull Long userId) {
        List<Permission> permissions = this.listUserPermission(userId);
        return permissionDtoConvert.doForward(permissions);
    }
}
