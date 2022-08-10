package cloud.flystar.solon.user.service.convert;

import cloud.flystar.solon.commons.dto.DTOConvert;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.api.dto.UserDto;
import cloud.flystar.solon.user.service.entity.Role;
import cloud.flystar.solon.user.service.entity.UserInfo;
import org.springframework.stereotype.Service;

@Service
public class RoleDtoConvert extends DTOConvert<Role, RoleDto> {
    @Override
    public RoleDto doForward(Role role) {
        RoleDto dto = new RoleDto();
        dto.setRoleId(role.getRoleId());
        dto.setRoleName(role.getRoleName());
        dto.setRoleSourceType(role.getRoleSourceType());
        dto.setRoleSourceId(role.getRoleSourceId());
        dto.setCreateTime(role.getCreateTime());
        dto.setCreateUserId(role.getCreateUserId());
        dto.setUpdateTime(role.getUpdateTime());
        dto.setUpdateUserId(role.getUpdateUserId());
        return dto;
    }

    @Override
    public Role doBackward(RoleDto roleDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}
