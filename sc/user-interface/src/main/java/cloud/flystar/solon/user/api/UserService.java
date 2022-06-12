package cloud.flystar.solon.user.api;

import cloud.flystar.solon.user.api.dto.UserDto;

public interface UserService {
    UserDto getUserDtoById(Long userId);
}
