package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import cloud.flystar.solon.core.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.service.RoleService;
import cloud.flystar.solon.user.service.convert.RoleDtoConvert;
import cloud.flystar.solon.user.service.entity.Role;
import cloud.flystar.solon.user.service.entity.UserRoleRef;
import cloud.flystar.solon.user.service.mapper.RoleMapper;
import cloud.flystar.solon.user.service.mapper.UserRoleRefMapper;
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
public class RoleServiceImpl extends BaseServiceImpl<RoleMapper, Role> implements RoleService {
    @Resource
    UserRoleRefMapper userRoleRefMapper;
    @Resource
    RoleDtoConvert roleDtoConvert;

    @Override
    public List<Role> listUserEnableRole(@NotNull Long userId) {
        List<UserRoleRef> userRoleRefs = ChainWrappers.lambdaQueryChain(userRoleRefMapper).eq(UserRoleRef::getUserId, userId).list();
        if(CollectionUtil.isEmpty(userRoleRefs)){
            return ListUtil.empty();
        }
        Set<Long> roleIds = userRoleRefs.stream().map(UserRoleRef::getRoleId).collect(Collectors.toSet());
        return this.lambdaQuery()
                .in(Role::getRoleId, roleIds)
                .eq(Role::getEnableFlag, YesOrNo.YES.getKey())
                .eq(Role::getDeleteFlag, YesOrNo.NO.getKey())
                .list();
    }

    @Override
    public List<RoleDto> listUserEnableRoleDto(@NotNull Long userId) {
        List<Role> roleList = this.listUserEnableRole(userId);
        return roleDtoConvert.doForward(roleList);
    }
}
