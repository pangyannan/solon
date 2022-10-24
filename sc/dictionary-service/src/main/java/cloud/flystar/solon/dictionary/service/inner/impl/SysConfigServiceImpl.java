package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.dictionary.service.inner.SysConfigService;
import cloud.flystar.solon.dictionary.service.entity.SysConfig;
import cloud.flystar.solon.dictionary.service.mapper.SysConfigMapper;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class SysConfigServiceImpl extends BaseServiceImpl<SysConfigMapper, SysConfig> implements SysConfigService {
}
