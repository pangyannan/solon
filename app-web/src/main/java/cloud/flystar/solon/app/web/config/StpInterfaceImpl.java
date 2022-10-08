package cloud.flystar.solon.app.web.config;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.api.dto.ResourceTypeEnum;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cn.dev33.satoken.stp.StpInterface;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 权限角色实现类
 */
@Component
public class StpInterfaceImpl implements StpInterface {
    @Resource
    private UserApi userApi;

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        if(loginId == null){
            return new ArrayList<>();
        }
        if(StrUtil.equals(GlobeConstant.ADMIN_USERID.toString(),loginId.toString())){
            return GlobeConstant.ADMIN_SA_PERMISSION;
        }
        List<ResourceInfoDto> resourceInfoDtoList = userApi.listUserResource((Long) loginId, ResourceTypeEnum.API.getKey(), GlobeConstant.PROJECT_CODE_WEB);
        return resourceInfoDtoList.stream().map(ResourceInfoDto::getResourceCode).distinct().collect(Collectors.toList());
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        if(loginId == null){
            return new ArrayList<>();
        }
        if(StrUtil.equals(GlobeConstant.ADMIN_USERID.toString(),loginId.toString())){
            return GlobeConstant.ADMIN_SA_ROLE;
        }
        List<RoleDto> roleDtoList = userApi.listUserEnableRole((Long) loginId);
        List<String> roleIds = roleDtoList.stream().map(t -> t.getRoleId().toString()).distinct().collect(Collectors.toList());
        return roleIds;
    }
}
