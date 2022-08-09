package cloud.flystar.solon.user.service.convert;

import cloud.flystar.solon.commons.dto.DTOConvert;
import cloud.flystar.solon.user.api.dto.UserDto;
import cloud.flystar.solon.user.service.entity.UserInfo;
import org.springframework.stereotype.Service;

@Service
public class UserDtoConvert  extends DTOConvert<UserInfo, UserDto> {
    @Override
    public UserDto doForward(UserInfo userInfo) {
        UserDto dto = new UserDto();
        dto.setUserId(userInfo.getUserId())
            .setUserName(userInfo.getUserName())
            .setPhone(userInfo.getPhone())
            .setEmail(userInfo.getEmail());
        return dto;
    }

    @Override
    public UserInfo doBackward(UserDto userDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}
