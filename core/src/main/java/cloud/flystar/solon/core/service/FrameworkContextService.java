package cloud.flystar.solon.core.service;

import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.bean.dto.user.UserTokenSessionInfo;
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
     * 获取当前用户登陆TOKEN信息
     */
    Optional<UserTokenSessionInfo> getUserTokenSessionInfoDefaultNull();
    /**
     * 获取当前用户登陆信息
     */
    Optional<UserSessionInfo> getUserSessionInfoDefaultNull();

    Optional<UserSessionInfo> getUserSessionInfoDefaultNull(Long userId);

}
