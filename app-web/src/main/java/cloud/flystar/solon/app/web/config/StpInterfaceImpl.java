package cloud.flystar.solon.app.web.config;

import cloud.flystar.solon.app.web.constant.GlobeConstant;
import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.api.dto.ResourceTypeEnum;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cn.dev33.satoken.stp.StpInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class StpInterfaceImpl implements StpInterface {
    @Autowired
    private UserApi userApi;

    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        if(loginId == null){
            return new ArrayList<>();
        }
        List<ResourceInfoDto> resourceInfoDtoList = userApi.listUserResource((Long) loginId, ResourceTypeEnum.API.getKey(), GlobeConstant.PROJECT_CODE);
        return resourceInfoDtoList.stream().map(ResourceInfoDto::getResourceCode).distinct().collect(Collectors.toList());
    }

    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        List<RoleDto> roleDtoList = userApi.listUserEnableRole((Long) loginId);
        return roleDtoList.stream().map(t->t.getRoleId().toString()).distinct().collect(Collectors.toList());
    }
}