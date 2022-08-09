package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.ResourceInfoService;
import cloud.flystar.solon.user.service.entity.ResourceInfo;
import cloud.flystar.solon.user.service.mapper.ResourceInfoMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ResourceInfoServiceImpl extends BaseServiceImpl<ResourceInfoMapper, ResourceInfo> implements ResourceInfoService {
}
