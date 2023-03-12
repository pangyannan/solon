package cloud.flystar.solon.quartz.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.quartz.service.JobLogService;
import cloud.flystar.solon.quartz.service.entity.JobLog;
import cloud.flystar.solon.quartz.service.mapper.JobLogMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.util.Date;


@Slf4j
@Service
@Validated
public class JobLogMapperImpl extends BaseServiceImpl<JobLogMapper, JobLog> implements JobLogService {
    @Override
    public void removeBeforeTime(@NotNull Long jobConfigId, @Past @NotNull Date beforeTime) {
        QueryWrapper wrapper = new QueryWrapper(new JobLog());
        wrapper.eq("job_config_id", jobConfigId);
        wrapper.le("start_time", beforeTime);
        this.remove(wrapper);
    }
}
