package cloud.flystar.solon.quartz.service;

import cloud.flystar.solon.quartz.service.entity.JobConfig;

/**
 * Quartz任务处理服务
 */
public interface QuartzJobHandler {
    /**
     * 添加任务
     */
     void addJob(JobConfig jobConfig);

    /**
     * 暂停任务
     */
     void pauseJob(JobConfig jobConfig);

    /**
     * 恢复任务
     */
     void resumeJob(JobConfig jobConfig);

    /**
     * 立即运行一次定时任务
     */
     void runOnce(JobConfig jobConfig);

    /**
     * 更新任务
     */
     void updateJob(JobConfig jobConfig);

    /**
     * 删除任务
     */
     void deleteJob(JobConfig jobConfig);

    /**
     * 启动所有任务
     */
     void startAllJobs();

    /**
     * 暂停所有任务
     */
     void pauseAllJobs();

    /**
     * 恢复所有任务
     */
     void resumeAllJobs();

    /**
     * 关闭所有任务
     */
     void shutdownAllJobs();
}
