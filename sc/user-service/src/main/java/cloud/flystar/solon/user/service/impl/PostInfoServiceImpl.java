package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.PostInfoService;
import cloud.flystar.solon.user.service.entity.PostInfo;
import cloud.flystar.solon.user.service.mapper.PostInfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class PostInfoServiceImpl extends BaseServiceImpl<PostInfoMapper, PostInfo> implements PostInfoService {
}
