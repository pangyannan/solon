package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.framework.service.FrameworkContextService;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.stereotype.Service;

@Service
public class FrameworkContextServiceImpl implements FrameworkContextService {
    @Override
    public Long currentUserId() {
        Object loginId = StpUtil.getLoginId();
        if(loginId == null){
            return  null;
        }
        return (Long) loginId;
    }
}
