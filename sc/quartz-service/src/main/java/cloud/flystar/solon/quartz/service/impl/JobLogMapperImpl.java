package cloud.flystar.solon.quartz.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.quartz.service.JobLogService;
import cloud.flystar.solon.quartz.service.entity.JobLog;
import cloud.flystar.solon.quartz.service.mapper.JobLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class JobLogMapperImpl extends BaseServiceImpl<JobLogMapper, JobLog> implements JobLogService {
}
