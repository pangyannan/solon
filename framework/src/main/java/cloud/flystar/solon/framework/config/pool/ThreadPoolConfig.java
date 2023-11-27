package cloud.flystar.solon.framework.config.pool;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.scheduling.concurrent.ExecutorConfigurationSupport;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 通用线程线程池配置
 */
@EnableConfigurationProperties({ThreadPoolProperties.class})
@Configuration
@RequiredArgsConstructor
@Slf4j
public class ThreadPoolConfig  implements ApplicationListener<ContextClosedEvent> {
    public static final String cpuExecutorName = "cpuExecutor";
    public static final String ioExecutorName = "ioExecutor";
    public static final String schedulerExecutor = "schedulerExecutor";
    private final ThreadPoolProperties threadPoolProperties;
    private final Map<String, ExecutorConfigurationSupport>  executorConfigurationSupportMap = new HashMap<>();

    /**
     * CPU密集型线程池
     * 默认CPU密集型--所有参数均需要在压测下不断调整，根据实际的任务消耗时间来设置参数
     * CPU密集型指的是高并发，相对短时间的计算型任务，这种会占用CPU执行计算处理
     * 因此核心线程数设置为CPU核数+1，减少线程的上下文切换，同时做个大的队列，避免任务被饱和策略拒绝。
     */
    @Bean(ThreadPoolConfig.cpuExecutorName)
    public ThreadPoolTaskExecutor cpuExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        //核心线程数，需要保活足够的线程数随时支持运行，提高响应速度，因此设置核心线程数为压测后的理论最优值
        Integer corePoolSize = Optional.ofNullable(threadPoolProperties.getCpuExecutorCorePoolSize()).orElse(Runtime.getRuntime().availableProcessors() + 1);
        executor.setCorePoolSize(corePoolSize);

        //非核心线程数 设置和核心线程数一致，用队列控制任务总数
        Integer maxPoolSize = Optional.ofNullable(threadPoolProperties.getCpuExecutorMaxPoolSize()).orElse(Runtime.getRuntime().availableProcessors() + 1);
        executor.setMaxPoolSize(maxPoolSize);


        //Spring默认使用LinkedBlockingQueue
        Integer queueCapacity = Optional.ofNullable(threadPoolProperties.getCpuExecutorQueueCapacity()).orElse(Runtime.getRuntime().availableProcessors()  * 1024);
        executor.setQueueCapacity(queueCapacity);

        //默认60秒，维持不变
        executor.setKeepAliveSeconds(60);
        //使用自定义前缀，方便问题排查
        executor.setThreadNamePrefix("cpuExecutor");
        //默认拒绝策略，由主线程来直接执行
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        //线程环境传递
        executor.setTaskDecorator(new TtlRunnableDecorator());

        // 告诉线程池，在销毁之前执行shutdown方法
        executor.setWaitForTasksToCompleteOnShutdown(true);
        // shutdown\shutdownNow 等待
        executor.setAwaitTerminationSeconds(10);

        executor.initialize();

        executorConfigurationSupportMap.put(ThreadPoolConfig.cpuExecutorName,executor);
        return executor;
    }


    /**
     * 默认io密集型线程池
     * IO密集型指的是有大量IO操作，比如远程调用、连接数据库
     * 因为IO操作不占用CPU，所以设置核心线程数为CPU核数的两倍，保证CPU不闲下来，队列相应调小一些。
     */
    @Bean(ThreadPoolConfig.ioExecutorName)
    public ThreadPoolTaskExecutor ioExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        //核心线程数，需要保活足够的线程数随时支持运行，提高响应速度，因此设置核心线程数为压测后的理论最优值
        Integer corePoolSize = Optional.ofNullable(threadPoolProperties.getIoExecutorCorePoolSize()).orElse(Runtime.getRuntime().availableProcessors() * 2);
        executor.setCorePoolSize(corePoolSize);

        //非核心线程数
        Integer maxPoolSize = Optional.ofNullable(threadPoolProperties.getIoExecutorMaxPoolSize()).orElse(Runtime.getRuntime().availableProcessors() * 8);
        executor.setMaxPoolSize(maxPoolSize);


        //Spring默认使用LinkedBlockingQueue
        Integer queueCapacity = Optional.ofNullable(threadPoolProperties.getIoExecutorQueueCapacity()).orElse(Runtime.getRuntime().availableProcessors()  * 64);
        executor.setQueueCapacity(queueCapacity);

        //线程存活时间 默认60秒
        executor.setKeepAliveSeconds(300);
        //使用自定义前缀，方便问题排查
        executor.setThreadNamePrefix("ioExecutor");
        //默认拒绝策略，由主线程来直接执行
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        //线程环境传递
        executor.setTaskDecorator(new TtlRunnableDecorator());



        // 告诉线程池，在销毁之前执行shutdown方法
        executor.setWaitForTasksToCompleteOnShutdown(true);
        // shutdown\shutdownNow 等待
        executor.setAwaitTerminationSeconds(30);

        executor.initialize();

        executorConfigurationSupportMap.put(ThreadPoolConfig.ioExecutorName,executor);
        return executor;
    }

    /**
     * 定时任务线程池
     * @return
     */
    @Bean(ThreadPoolConfig.schedulerExecutor)
    public ThreadPoolTaskScheduler schedulerExecutor() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();

        Integer poolSize = Optional.ofNullable(threadPoolProperties.getSchedulerCorePoolSize()).orElse(Runtime.getRuntime().availableProcessors());
        scheduler.setPoolSize(poolSize);

        scheduler.setWaitForTasksToCompleteOnShutdown(true); //是否等待任务完成再销毁
        scheduler.setAwaitTerminationSeconds(60); //最多等待60秒

        //使用自定义前缀，方便问题排查
        scheduler.setThreadNamePrefix("ioExecutor");
        //默认拒绝策略，处理程序遭到拒绝将抛出RejectedExecutionException
        scheduler.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());


        // 告诉线程池，在销毁之前执行shutdown方法
        scheduler.setWaitForTasksToCompleteOnShutdown(true);
        // shutdown\shutdownNow 等待
        scheduler.setAwaitTerminationSeconds(10);

        scheduler.initialize();

        executorConfigurationSupportMap.put(ThreadPoolConfig.schedulerExecutor,scheduler);
        return scheduler;
    }


    @Override
    public void onApplicationEvent(ContextClosedEvent event) {
        for (Map.Entry<String, ExecutorConfigurationSupport> supportEntry : executorConfigurationSupportMap.entrySet()) {
            String key = supportEntry.getKey();
            log.info("开始关闭线程池[{}]",key);
            supportEntry.getValue().destroy();
        }
    }
}
