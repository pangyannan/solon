package cloud.flystar.solon.core.config;

import cloud.flystar.solon.core.config.pool.ThreadPoolConfig;
import cloud.flystar.solon.core.config.pool.ThreadPoolHolder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

/**
 * 定时任务线程池配置
 */
@Configuration
@ConditionalOnBean(ThreadPoolConfig.class)
public class SchedulerConfig implements SchedulingConfigurer {
    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        ThreadPoolTaskScheduler threadPoolTaskScheduler = ThreadPoolHolder.schedulerExecutor();
        taskRegistrar.setTaskScheduler(threadPoolTaskScheduler);
    }

}
