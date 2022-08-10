package cloud.flystar.solon.user.service.convert;

import cloud.flystar.solon.commons.dto.DTOConvert;
import cloud.flystar.solon.user.api.dto.PermissionDto;
import cloud.flystar.solon.user.api.dto.RoleDto;
import cloud.flystar.solon.user.service.entity.Permission;
import cloud.flystar.solon.user.service.entity.Role;
import org.springframework.stereotype.Service;

@Service
public class PermissionDtoConvert extends DTOConvert<Permission, PermissionDto> {
    @Override
    public PermissionDto doForward(Permission permission) {
        PermissionDto dto = new PermissionDto();
        dto.setPermissionId(permission.getPermissionId());
        dto.setPermissionCode(permission.getPermissionCode());
        dto.setPermissionName(permission.getPermissionName());

        dto.setCreateTime(permission.getCreateTime());
        dto.setCreateUserId(permission.getCreateUserId());
        dto.setUpdateTime(permission.getUpdateTime());
        dto.setUpdateUserId(permission.getUpdateUserId());
        return dto;
    }

    @Override
    public Permission doBackward(PermissionDto roleDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}