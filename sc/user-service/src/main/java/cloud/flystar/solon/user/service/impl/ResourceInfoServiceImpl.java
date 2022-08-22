package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.service.PermissionService;
import cloud.flystar.solon.user.service.ResourceInfoService;
import cloud.flystar.solon.user.service.convert.ResourceInfoDtoConvert;
import cloud.flystar.solon.user.service.entity.Permission;
import cloud.flystar.solon.user.service.entity.PermissionResourceRef;
import cloud.flystar.solon.user.service.entity.ResourceInfo;
import cloud.flystar.solon.user.service.mapper.PermissionResourceRefMapper;
import cloud.flystar.solon.user.service.mapper.ResourceInfoMapper;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.toolkit.ChainWrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
@Validated
public class ResourceInfoServiceImpl extends BaseServiceImpl<ResourceInfoMapper, ResourceInfo> implements ResourceInfoService {
    @Resource
    PermissionResourceRefMapper permissionResourceRefMapper;
    @Resource
    PermissionService permissionService;
    @Resource
    ResourceInfoDtoConvert resourceInfoDtoConvert;

    @Override
    public List<ResourceInfo> listUserResource(@NotNull Long userId, @NotBlank String resourceType, String projectCode) {
        List<Permission> permissions = permissionService.listUserPermission(userId);
        if(CollectionUtil.isEmpty(permissions)){
            return Lists.newArrayList();
        }
        Set<Long> permissionIds = permissions.stream().map(Permission::getPermissionId).collect(Collectors.toSet());
        List<PermissionResourceRef> permissionResourceRefs = ChainWrappers.lambdaQueryChain(permissionResourceRefMapper)
                .eq(PermissionResourceRef::getResourceType,resourceType)
                .in(PermissionResourceRef::getPermissionId, permissionIds)
                .list();
        if(CollectionUtil.isEmpty(permissionResourceRefs)){
            return Lists.newArrayList();
        }
        Set<Long> resourceIds = permissionResourceRefs.stream().map(PermissionResourceRef::getResourceId).collect(Collectors.toSet());
        return this.lambdaQuery()
                .in(ResourceInfo::getResourceId,resourceIds)
                .eq(ResourceInfo::getResourceType,resourceType)
                .eq(StrUtil.isNotBlank(projectCode),ResourceInfo::getProjectCode,permissionIds)
                .list();
    }

    @Override
    public List<ResourceInfoDto> listUserResourceDto(@NotNull Long userId, @NotBlank String resourceType, String projectCode) {
        List<ResourceInfo> resourceInfos = this.listUserResource(userId, resourceType,projectCode);
        return resourceInfoDtoConvert.doForward(resourceInfos);
    }
}
