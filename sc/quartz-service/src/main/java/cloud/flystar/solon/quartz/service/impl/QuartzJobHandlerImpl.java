package cloud.flystar.solon.quartz.service.impl;

import cloud.flystar.solon.quartz.service.QuartzJobHandler;
import cloud.flystar.solon.quartz.service.config.JobConstants;
import cloud.flystar.solon.quartz.service.entity.JobConfig;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;


@Slf4j
@Service
public class QuartzJobHandlerImpl implements QuartzJobHandler {
    @Autowired
    private Scheduler scheduler;


    @SneakyThrows
    @Override
    public void addJob(JobConfig jobConfig) {
        // 创建jobDetail实例， 绑定Job实现类
        // 指明job的名称，所在组的名称，以及绑定Job类
        String className = jobConfig.getClassName();
        Class<?> jobClassCheck = Class.forName(className);
        Assert.notNull(jobClassCheck,"className="+className+" 不是org.quartz.Job的子类");
        Assert.isTrue(Job.class.isAssignableFrom(jobClassCheck),"className="+className+" 不是org.quartz.Job的子类");

        Class<? extends Job> jobClass = (Class<? extends Job>) Class.forName(className);
        // 配置任务名称和组构成任务key
        JobDetail jobDetail = JobBuilder
                .newJob(jobClass)
                .withIdentity(this.getJobKey(jobConfig))
                .build();

        // 定义调度规则
        TriggerBuilder<CronTrigger> triggerTriggerBuilder = TriggerBuilder
                .newTrigger()
                .withIdentity(jobConfig.getId().toString())
                .withSchedule(CronScheduleBuilder.cronSchedule(jobConfig.getCron()));

        if(jobConfig.getStartTime() != null){
            triggerTriggerBuilder.startAt(jobConfig.getStartTime());
        }else{
            triggerTriggerBuilder.startAt(DateBuilder.futureDate(5, DateBuilder.IntervalUnit.SECOND));
        }
        if(jobConfig.getEndTime() !=null ){
            triggerTriggerBuilder.endAt(jobConfig.getEndTime());
        }
        Trigger trigger = triggerTriggerBuilder.build();


        jobDetail.getJobDataMap().put(JobConstants.JOB_CONFIG, jobConfig);

        // 判断是否存在
        if (scheduler.checkExists(this.getJobKey(jobConfig))) {
            // 防止创建时存在数据问题 先移除，然后在执行创建操作
            scheduler.deleteJob(this.getJobKey(jobConfig));
        }
        // 把job和触发器注册到任务调度中
        scheduler.scheduleJob(jobDetail, trigger);
        if (jobConfig.getStatus() ==  0) {
            pauseJob(jobConfig);
        }
    }

    @SneakyThrows
    @Override
    public void pauseJob(JobConfig jobConfig) {
        scheduler.pauseJob(this.getJobKey(jobConfig));
    }

    @SneakyThrows
    @Override
    public void resumeJob(JobConfig jobConfig) {
        scheduler.resumeJob(this.getJobKey(jobConfig));

    }

    @SneakyThrows
    @Override
    public void runOnce(JobConfig jobConfig) {
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(JobConstants.JOB_CONFIG, jobConfig);
        scheduler.triggerJob(this.getJobKey(jobConfig), dataMap);

    }

    @SneakyThrows
    @Override
    public void updateJob(JobConfig jobConfig) {
       this.deleteJob(jobConfig);
       this.addJob(jobConfig);
    }

    @SneakyThrows
    @Override
    public void deleteJob(JobConfig jobConfig) {
        // 暂停、移除、删除
        scheduler.pauseTrigger(TriggerKey.triggerKey(jobConfig.getId().toString()));
        scheduler.unscheduleJob(TriggerKey.triggerKey(jobConfig.getId().toString()));
        scheduler.deleteJob(this.getJobKey(jobConfig));

    }

    @SneakyThrows
    @Override
    public void startAllJobs() {
        scheduler.start();
    }

    @SneakyThrows
    @Override
    public void pauseAllJobs() {
        scheduler.pauseAll();
    }

    @SneakyThrows
    @Override
    public void resumeAllJobs() {
        scheduler.resumeAll();
    }

    @SneakyThrows
    @Override
    public void shutdownAllJobs() {
        if (!scheduler.isShutdown()) {
            // 需谨慎操作关闭scheduler容器
            // scheduler生命周期结束，无法再 start() 启动scheduler
            scheduler.shutdown(true);
        }
    }

    /**
     * 构建任务键对象
     */
    public static JobKey getJobKey(JobConfig jobConfig) {
        return JobKey.jobKey(jobConfig.getId().toString());
    }
}
