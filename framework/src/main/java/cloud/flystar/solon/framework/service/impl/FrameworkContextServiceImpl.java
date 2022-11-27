package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.user.UserDataResourceScope;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.bean.dto.user.UserTokenSessionInfo;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.framework.service.FrameworkContextService;
import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.collection.ListUtil;
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
    public Optional<UserTokenSessionInfo> getUserTokenSessionInfoDefaultNull() {
        SaSession tokenSession = StpUtil.stpLogic.getTokenSession(false);
        if(tokenSession == null){
            return Optional.empty();
        }
        String userTokenSessionInfoJson = (String)tokenSession.get(GlobeConstant.TOKEN_SESSION_USER_KEY);
        if(StrUtil.isBlank(userTokenSessionInfoJson)){
            return Optional.empty();
        }
        UserTokenSessionInfo userTokenSessionInfo = JsonUtil.jsonToBean(userTokenSessionInfoJson, UserTokenSessionInfo.class);

        return Optional.ofNullable(userTokenSessionInfo);
    }


    @Override
    public Optional<UserSessionInfo> getUserSessionInfoDefaultNull() {
        Long userId = this.getLoginIdDefaultNull();
        return getUserSessionInfoDefaultNull(userId);
    }


    @Override
    public Optional<UserSessionInfo> getUserSessionInfoDefaultNull(Long userId) {
        if(userId == null){
            return Optional.empty();
        }
        if(userId == 1L){
            UserSessionInfo userSessionInfo = new UserSessionInfo();
            userSessionInfo.setUserId(userId);
            userSessionInfo.setUserName("admin");
            userSessionInfo.setDeptIds(ListUtil.toList(1L));
            userSessionInfo.setManagementDeptIds(ListUtil.toList(1L,2L,3L));

            UserDataResourceScope userDataResourceScope = new UserDataResourceScope();
            userDataResourceScope.setDataResourceKey("/data/mdm/gbt2260");
            userDataResourceScope.setDataScopeCodes(ListUtil.toList("deptChild","deptCurrent","creator"));
            userSessionInfo.setUserDataResourceScopes(ListUtil.toList(userDataResourceScope));
            return Optional.of(userSessionInfo);
        }



        SaSession userSession = StpUtil.getSessionByLoginId(userId,false);
        if(userSession == null){
            return Optional.empty();
        }

        String userSessionInfoJson = (String)userSession.get(GlobeConstant.SESSION_USER_KEY);
        if(StrUtil.isBlank(userSessionInfoJson)){
            return Optional.empty();
        }
        UserSessionInfo userSessionInfo = JsonUtil.jsonToBean(userSessionInfoJson, UserSessionInfo.class);
        return Optional.ofNullable(userSessionInfo);
    }
}
