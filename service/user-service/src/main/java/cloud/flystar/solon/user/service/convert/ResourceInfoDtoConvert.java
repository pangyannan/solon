package cloud.flystar.solon.user.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.service.entity.ResourceInfo;
import org.springframework.stereotype.Service;

@Service
public class ResourceInfoDtoConvert extends DTOConvert<ResourceInfo, ResourceInfoDto> {
    @Override
    public ResourceInfoDto doForward(ResourceInfo resourceInfo) {
        if(resourceInfo == null){
            return  null;
        }
        ResourceInfoDto dto = new ResourceInfoDto();
        dto.setResourceId(resourceInfo.getResourceId());
        dto.setResourceType(resourceInfo.getResourceType());
        dto.setResourceCode(resourceInfo.getResourceCode());
        dto.setResourceName(resourceInfo.getResourceName());

        dto.setCreateTime(resourceInfo.getCreateTime());
        dto.setCreateUserId(resourceInfo.getCreateUserId());
        dto.setUpdateTime(resourceInfo.getUpdateTime());
        dto.setUpdateUserId(resourceInfo.getUpdateUserId());
        return dto;
    }

    @Override
    public ResourceInfo doBackward(ResourceInfoDto roleDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}
