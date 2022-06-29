package cloud.flystar.solon.user.service;

import cloud.flystar.solon.user.api.UserService;
import cloud.flystar.solon.user.api.dto.UserDto;
import cn.hutool.core.date.DateUtil;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Override
    public UserDto getUserDtoById(Long userId) {
        return new UserDto()
                .setId(1L)
                .setUserName("admin")
                .setEmail("admin@flystar.cloud")
                .setPhone("13800000000");
    }
}
