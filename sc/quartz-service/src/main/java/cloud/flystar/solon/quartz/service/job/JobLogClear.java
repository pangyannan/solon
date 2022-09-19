package cloud.flystar.solon.quartz.service.job;

import cloud.flystar.solon.quartz.service.AbstractQuartzJob;
import cloud.flystar.solon.quartz.service.JobConfigService;
import cloud.flystar.solon.quartz.service.JobLogService;
import cloud.flystar.solon.quartz.service.entity.JobConfig;
import cloud.flystar.solon.quartz.service.entity.JobLog;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;
import org.quartz.PersistJobDataAfterExecution;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 定时清理日志
 */
@Service
@PersistJobDataAfterExecution
@DisallowConcurrentExecution
public class JobLogClear extends AbstractQuartzJob {
    @Autowired
    private JobLogService jobLogService;
    @Autowired
    private JobConfigService jobConfigService;

    @Override
    protected void doExecute(JobExecutionContext context, JobConfig jobConfig) {
        List<JobConfig> list = jobConfigService.list();
        for (JobConfig config : list) {
            Integer maxLogDay = config.getMaxLogDay();
            if(maxLogDay != null){
                //保留日志的最大天数
                DateTime dateTime = DateUtil.offsetDay(DateTime.now(), -maxLogDay);
                QueryWrapper wrapper = new QueryWrapper(new JobLog());
                wrapper.eq("job_config_id", config.getId());
                wrapper.le("start_time", dateTime);
                jobLogService.remove(wrapper);
            }
        }
    }
}
