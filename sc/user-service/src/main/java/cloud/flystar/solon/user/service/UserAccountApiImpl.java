package cloud.flystar.solon.user.service;

import cloud.flystar.solon.user.api.UserAccountApi;
import cloud.flystar.solon.user.api.dto.UserAccountDto;
import cloud.flystar.solon.user.service.convert.UserAccountDtoConvert;
import cloud.flystar.solon.user.service.entity.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotBlank;


@Service
public class UserAccountApiImpl implements UserAccountApi {
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private UserAccountDtoConvert userAccountDtoConvert;
    @Override
    public UserAccountDto getBaseAccountByUserName(@NotBlank String userName) {
        UserInfo userInfo = userInfoService.getByUserName(userName);
        return userAccountDtoConvert.doForward(userInfo);
    }
}
