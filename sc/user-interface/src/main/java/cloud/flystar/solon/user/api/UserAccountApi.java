package cloud.flystar.solon.user.api;

import cloud.flystar.solon.user.api.dto.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * 用户账号服务
 */
public interface UserAccountApi {
    /**
     * 根据用户名查询账号基本
     * @param userName
     * @return
     */
    UserAccountDto getBaseAccountByUserName(@NotBlank String userName);
}
