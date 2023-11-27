package cloud.flystar.solon.core.config.pool;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 线程池配置
 */
@Configuration
@ConfigurationProperties(prefix = "thread.pool")
@Data
public class ThreadPoolProperties {

    //cpu密集型线程配置
    private Integer cpuExecutorCorePoolSize;
    private Integer cpuExecutorMaxPoolSize;
    private Integer cpuExecutorQueueCapacity;
    private Integer cpuExecutorKeepAliveSeconds;


    //cpu密集型线程配置
    private Integer ioExecutorCorePoolSize;
    private Integer ioExecutorMaxPoolSize;
    private Integer ioExecutorQueueCapacity;
    private Integer ioExecutorKeepAliveSeconds;


    //内置定时任务线程池
    private Integer schedulerCorePoolSize;


}
