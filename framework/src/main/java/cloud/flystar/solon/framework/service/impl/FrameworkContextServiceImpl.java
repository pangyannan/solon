package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.format.json.JsonUtil;
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
        Object loginId = StpUtil.getLoginIdDefaultNull();
        if(loginId == null){
            return  null;
        }
        return (Long) loginId;
    }

    @Override
    @NonNull
    public Long getLoginId() {
        return (Long)StpUtil.getLoginId();
    }

    @Override
    public Optional<UserSessionInfo> getUserSessionInfoDefaultNull() {
        SaSession tokenSession = StpUtil.stpLogic.getTokenSession(false);
        if(tokenSession == null){
            return Optional.empty();
        }
        String userSessionInfoJson = (String)tokenSession.get(GlobeConstant.SESSION_USER_KEY);
        if(StrUtil.isBlank(userSessionInfoJson)){
            return Optional.empty();
        }
        UserSessionInfo userSessionInfo = JsonUtil.jsonToBean(userSessionInfoJson, UserSessionInfo.class);

        return Optional.ofNullable(userSessionInfo);
    }
}
