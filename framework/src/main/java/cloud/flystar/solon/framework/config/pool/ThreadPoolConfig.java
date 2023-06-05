package cloud.flystar.solon.framework.config.pool;

import cn.hutool.core.thread.RejectPolicy;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.Optional;
import java.util.stream.LongStream;

/**
 * 通用线程线程池配置
 */
@EnableConfigurationProperties({ThreadPoolProperties.class})
@Configuration
@RequiredArgsConstructor
public class ThreadPoolConfig {
    final ThreadPoolProperties threadPoolProperties;


    /**
     * 默认CPU密集型--所有参数均需要在压测下不断调整，根据实际的任务消耗时间来设置参数
     * CPU密集型指的是高并发，相对短时间的计算型任务，这种会占用CPU执行计算处理
     * 因此核心线程数设置为CPU核数+1，减少线程的上下文切换，同时做个大的队列，避免任务被饱和策略拒绝。
     */
    @Bean("cpuExecutor")
    public ThreadPoolTaskExecutor cpuExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        //获取逻辑可用CPU数
        Integer poolCpuNumber = Optional.ofNullable(threadPoolProperties.getPoolCpuNumber()).orElse(Runtime.getRuntime().availableProcessors());
        //如果是核心业务，需要保活足够的线程数随时支持运行，提高响应速度，因此设置核心线程数为压测后的理论最优值
        executor.setCorePoolSize(poolCpuNumber + 1);
        //设置和核心线程数一致，用队列控制任务总数
        executor.setMaxPoolSize(poolCpuNumber + 1);
        //Spring默认使用LinkedBlockingQueue
        executor.setQueueCapacity(poolCpuNumber * 32);

        //默认60秒，维持不变
        executor.setKeepAliveSeconds(60);
        //使用自定义前缀，方便问题排查
        executor.setThreadNamePrefix("cpuExecutor");
        //默认拒绝策略，调用者执行
        executor.setRejectedExecutionHandler(RejectPolicy.CALLER_RUNS.getValue());
        //线程环境传递
        executor.setTaskDecorator(new ContextCopyingDecorator());

        sum = LongStream.rangeClosed(0, 1000000000L).parallel().sum();

        executor.initialize();
        return executor;
    }


    /**
     * 默认io密集型
     * IO密集型指的是有大量IO操作，比如远程调用、连接数据库
     * 因为IO操作不占用CPU，所以设置核心线程数为CPU核数的两倍，保证CPU不闲下来，队列相应调小一些。
     */
    @Bean("ioExecutor")
    public ThreadPoolTaskExecutor ioExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        Integer poolCpuNumber = Optional.ofNullable(threadPoolProperties.getPoolCpuNumber()).orElse(Runtime.getRuntime().availableProcessors());

        //如果是核心业务，需要保活足够的线程数随时支持运行，提高响应速度，因此设置核心线程数为压测后的理论最优值
        executor.setCorePoolSize(poolCpuNumber * 2 + 1);
        //设置和核心线程数一致，用队列控制任务总数
        executor.setMaxPoolSize(poolCpuNumber * 2 + 1);
        //Spring默认使用LinkedBlockingQueue
        executor.setQueueCapacity(poolCpuNumber * 2 * 64);

        //默认120秒，维持不变
        executor.setKeepAliveSeconds(120);
        //使用自定义前缀，方便问题排查
        executor.setThreadNamePrefix("ioExecutor");
        //默认拒绝策略，调用者执行
        executor.setRejectedExecutionHandler(RejectPolicy.CALLER_RUNS.getValue());
        //线程环境传递
        executor.setTaskDecorator(new ContextCopyingDecorator());


        executor.initialize();
        return executor;
    }

}
