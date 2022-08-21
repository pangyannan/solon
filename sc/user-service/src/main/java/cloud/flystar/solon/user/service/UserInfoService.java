package cloud.flystar.solon.user.service;

import cloud.flystar.solon.framework.service.IBaseService;
import cloud.flystar.solon.user.service.entity.UserInfo;

import javax.validation.constraints.NotBlank;


public interface UserInfoService extends IBaseService<UserInfo> {
     UserInfo getByUserName(@NotBlank String userName);
}
