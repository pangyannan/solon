package cloud.flystar.solon.user.service.convert;

import cloud.flystar.solon.commons.dto.DTOConvert;
import cloud.flystar.solon.user.api.dto.UserAccountDto;
import cloud.flystar.solon.user.service.entity.UserInfo;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

/**
 * 用户转账户
 */
@Service
@Validated
public class UserAccountDtoConvert extends DTOConvert<UserInfo, UserAccountDto> {
    @Override
    public UserAccountDto doForward(UserInfo userInfo) {
        UserAccountDto dto = new UserAccountDto();
        dto.setUserId(userInfo.getUserId())
                .setUserName(userInfo.getUserName())
                .setPassword(userInfo.getPassword())
                .setEnable(userInfo.getEnable())
                .setDeleteFlag(userInfo.getDeleteFlag());
        return dto;
    }

    @Override
    public UserInfo doBackward(UserAccountDto userAccountDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}
