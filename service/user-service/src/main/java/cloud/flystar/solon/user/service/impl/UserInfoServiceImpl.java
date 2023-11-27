package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.core.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.UserInfoService;
import cloud.flystar.solon.user.service.entity.UserInfo;
import cloud.flystar.solon.user.service.mapper.UserInfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotBlank;

@Slf4j
@Service
@Validated
public class UserInfoServiceImpl extends BaseServiceImpl<UserInfoMapper,UserInfo> implements UserInfoService {

    @Override
    public UserInfo getByUserName(@NotBlank String userName) {
        return this.lambdaQuery().eq(UserInfo::getUserName,userName).one();
    }
}
