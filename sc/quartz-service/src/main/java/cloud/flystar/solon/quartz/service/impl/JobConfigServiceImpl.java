package cloud.flystar.solon.quartz.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.quartz.service.JobConfigService;
import cloud.flystar.solon.quartz.service.entity.JobConfig;
import cloud.flystar.solon.quartz.service.mapper.JobConfigMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 *
 */
@Slf4j
@Service
public class JobConfigServiceImpl extends BaseServiceImpl<JobConfigMapper, JobConfig> implements JobConfigService {
}
