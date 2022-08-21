package cloud.flystar.solon.user.service;

import cloud.flystar.solon.framework.service.IBaseService;
import cloud.flystar.solon.user.api.dto.ResourceInfoDto;
import cloud.flystar.solon.user.service.entity.ResourceInfo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

public interface ResourceInfoService extends IBaseService<ResourceInfo> {
    List<ResourceInfo> listUserResource(@NotNull Long userId, @NotBlank String resourceType,String projectCode);
    List<ResourceInfoDto> listUserResourceDto(@NotNull Long userId, @NotBlank String resourceType,String projectCode);

}
