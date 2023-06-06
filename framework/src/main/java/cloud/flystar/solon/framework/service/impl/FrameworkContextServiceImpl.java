package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.bean.dto.user.UserTokenSessionInfo;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.framework.constant.WebThreadContextKey;
import cloud.flystar.solon.commons.pool.WebThreadContextUtil;
import cloud.flystar.solon.framework.service.FrameworkContextService;
import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class FrameworkContextServiceImpl implements FrameworkContextService {
    @Override
    @Nullable
    public Long getLoginIdDefaultNull() {
        if(WebThreadContextUtil.containsKey(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID)){
            return (Long) WebThreadContextUtil.get(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID);
        }

        Long loginId = (Long)StpUtil.getLoginIdDefaultNull();
        WebThreadContextUtil.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID,loginId);
        return loginId;
    }

    @Override
    @NonNull
    public Long getLoginId() {
        Long loginId = (Long) WebThreadContextUtil.get(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID);
        if(loginId != null){
            return loginId;
        }
        loginId = (Long)StpUtil.getLoginId();
        WebThreadContextUtil.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID,loginId);
        return loginId;
    }

    @Override
    public Optional<UserTokenSessionInfo> getUserTokenSessionInfoDefaultNull() {
        if(WebThreadContextUtil.containsKey(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_TOKENSESSION)){
            return (Optional<UserTokenSessionInfo>) WebThreadContextUtil.get(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_TOKENSESSION);
        }

        Optional<UserTokenSessionInfo> optional = Optional.empty();
        SaSession tokenSession = StpUtil.stpLogic.getTokenSession(false);
        if(tokenSession != null){
            String userTokenSessionInfoJson = (String)tokenSession.get(GlobeConstant.TOKEN_SESSION_USER_KEY);
            if(StrUtil.isNotBlank(userTokenSessionInfoJson)){
                UserTokenSessionInfo userTokenSessionInfo = JsonUtil.jsonToBean(userTokenSessionInfoJson, UserTokenSessionInfo.class);
                optional = Optional.ofNullable(userTokenSessionInfo);
            }
        }
        WebThreadContextUtil.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_TOKENSESSION,optional);
        return optional;
    }


    @Override
    public Optional<UserSessionInfo> getUserSessionInfoDefaultNull() {
        Long userId = this.getLoginIdDefaultNull();
        return this.getUserSessionInfoDefaultNull(userId);
    }


    @Override
    public Optional<UserSessionInfo> getUserSessionInfoDefaultNull(Long userId) {
        if(userId == null){
            return Optional.empty();
        }

        if(WebThreadContextUtil.containsKey(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_SESSION)){
            return (Optional<UserSessionInfo>) WebThreadContextUtil.get(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_SESSION);
        }

        Optional<UserSessionInfo> optional = Optional.empty();
        SaSession userSession = StpUtil.getSessionByLoginId(userId,false);
        if(userSession != null){
            String userSessionInfoJson = (String)userSession.get(GlobeConstant.SESSION_USER_KEY);
            if(StrUtil.isNotBlank(userSessionInfoJson)) {
                UserSessionInfo userSessionInfo = JsonUtil.jsonToBean(userSessionInfoJson, UserSessionInfo.class);
                optional = Optional.ofNullable(userSessionInfo);
            }
        }
        WebThreadContextUtil.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_SESSION,optional);
        return optional;
    }

}
