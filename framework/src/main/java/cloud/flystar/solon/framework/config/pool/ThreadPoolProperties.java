package cloud.flystar.solon.framework.config.pool;

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
    /**
     * cpu核数,一般使用系统默认
     */
    private Integer poolCpuNumber;

}
