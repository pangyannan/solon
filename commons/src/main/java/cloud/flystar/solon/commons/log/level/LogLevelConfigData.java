package cloud.flystar.solon.commons.log.level;

import lombok.Data;
import org.springframework.boot.logging.LogLevel;

/**
 * @Author: pangyannan
 * @Data: 2021/6/25
 * @Description: 日志级别配置类
 */
@Data
public class LogLevelConfigData {
    /**
    * the name of the logger
    */
    private String loggerName;

    /**
     * the log level
     * @see LogLevel
     */
    private String level;

}
