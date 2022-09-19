package cloud.flystar.solon.quartz.service;

import cloud.flystar.solon.commons.util.IpUtil;
import cloud.flystar.solon.quartz.service.config.JobConstants;
import cloud.flystar.solon.quartz.service.entity.JobConfig;
import cloud.flystar.solon.quartz.service.entity.JobLog;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import java.time.LocalDateTime;

/**
 * 定时任务的抽象类，所有的自定义任务方法都应该实现此方法
 */
@Slf4j
public abstract class AbstractQuartzJob implements Job {
    private static String localIp  = null;
    /**
     * 线程本地变量
     */
    private static ThreadLocal<JobLog> threadLocal = new ThreadLocal<>();


    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        JobConfig jobConfig = (JobConfig)context.getMergedJobDataMap().get(JobConstants.JOB_CONFIG);
        try {
            this.before(context,jobConfig);
            this.doExecute(context, jobConfig);
            this.after(context, jobConfig, null);
        } catch (Exception ex) {
            log.error("定时任务执行异常",ex);
            this.after(context, jobConfig, ex);
        }finally {
            threadLocal.remove();
        }
    }

    /**
     * 具体执行任务方法
     * @param context
     * @param jobConfig
     */
    protected abstract void doExecute(JobExecutionContext context, JobConfig jobConfig);


    /**
     * 执行前
     * @param context 工作执行上下文对象
     */
    protected void before(JobExecutionContext context,JobConfig jobConfig) {
        log.info("开始执行定时任务[{}],任务参数[{}]",jobConfig.getJobGroup(),jobConfig.getParam());
        JobLog jobLog = new JobLog();
        jobLog.setStartTime(LocalDateTime.now());
        threadLocal.set(jobLog);
    }


    protected void after(JobExecutionContext context, JobConfig jobConfig, Exception ex) {
        log.info("结束执行定时任务[{}],任务参数[{}]",jobConfig.getJobGroup(),jobConfig.getParam());

        JobLog jobLog = threadLocal.get();
        jobLog.setJobConfigId(jobConfig.getId());
        jobLog.setEndTime(LocalDateTime.now());
        jobLog.setInstanceIp(this.getLocalIp());

        if(ex == null){
            jobLog.setJobSuccess(1);
            jobLog.setMessage("success");
        }else{
            jobLog.setJobSuccess(0);
            jobLog.setMessage(StrUtil.subPre(ex.getMessage(),200));
        }

        //保存任务日志
        JobLogService jobLogService = SpringUtil.getBean(JobLogService.class);
        jobLogService.save(jobLog);
    }


    private String getLocalIp(){
        if (localIp == null){
            localIp = IpUtil.getHostIp();
        }
        return localIp;
    }
}
