package cloud.flystar.solon.user.api;

import cloud.flystar.solon.user.api.dto.UserDto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.List;

/**
 * 用户服务API
 * 用于向其他模块提供服务
 */
public interface UserApi {
    UserDto getById(@NotNull Long userId);

    /**
     * 按照用户ID集合查询
     * @param userIds
     * @return
     */
    List<UserDto> listByIds(@NotEmpty @Size(max = 1000) List<Long> userIds);
    UserDto getByUserName(@NotBlank String userName);
}
