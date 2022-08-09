package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.UserInfoService;
import cloud.flystar.solon.user.service.entity.UserInfo;
import cloud.flystar.solon.user.service.mapper.UserInfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class UserInfoServiceImpl extends BaseServiceImpl<UserInfoMapper,UserInfo> implements UserInfoService {

}
