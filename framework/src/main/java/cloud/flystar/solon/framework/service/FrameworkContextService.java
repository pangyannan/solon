package cloud.flystar.solon.framework.service;

import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

import java.util.Optional;

/**
 * 环境服务
 */
public interface FrameworkContextService {
    /**
     * 获取当前用户登陆id
     */
    @Nullable
    Long getLoginIdDefaultNull();

    /**
     * 获取当前用户登陆id,如果未登陆则抛出异常
     */
    @NonNull
    Long getLoginId();

    /**
     * 获取当前用户登陆信息
     */
    Optional<UserSessionInfo> getUserSessionInfoDefaultNull();
}
