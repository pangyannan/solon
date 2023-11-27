package cloud.flystar.solon.commons.log.level;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.logging.LogLevel;
import org.springframework.boot.logging.LoggerConfiguration;
import org.springframework.boot.logging.LoggingSystem;
import org.springframework.util.CollectionUtils;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: pangyannan
 * @Data: 2021/6/25
 * @Description: 动态修改日志级别服务
 */
@Slf4j
public class LogLevelService {
    private LoggingSystem loggingSystem;
    public LogLevelService(LoggingSystem loggingSystem) {
        this.loggingSystem = loggingSystem;
    }

    /**
     * 动态更改ROOT的日志级别
     * @param level 取值范围 TRACE, DEBUG, INFO, WARN, ERROR, FATAL, OFF
     */
    public void setRootLoggerLevel(String level) {
        LogLevelConfigData logLevelConfigData = new LogLevelConfigData();
        logLevelConfigData.setLoggerName(LoggingSystem.ROOT_LOGGER_NAME);
        logLevelConfigData.setLevel(level);
        this.setLoggerLevel(Arrays.asList(logLevelConfigData));
    }

    /**
     * 动态更改log的级别
     * @param configList
     */
    public void setLoggerLevel(List<LogLevelConfigData> configList) {
        if(CollectionUtils.isEmpty(configList)){
            log.error("configList is empty");
            return;
        }
        for (LogLevelConfigData config : configList) {

            LoggerConfiguration loggerConfiguration = loggingSystem.getLoggerConfiguration(config.getLoggerName());
            if (loggerConfiguration == null) {
                log.error("no loggerConfiguration with loggerName [{}]" , config.getLoggerName());
                continue;
            }

            List<String> supportLevels = supportLevels();
            if (!supportLevels.contains(config.getLevel())) {
                String supportLevelsString = supportLevels.stream().collect(Collectors.joining(","));
                log.error("current Level is not support [{}], level in [{}]" , config.getLevel() ,supportLevelsString);
                continue;
            }

            if (!loggerConfiguration.getEffectiveLevel().equals(LogLevel.valueOf(config.getLevel()))) {
                log.info("setLogLevel success,old level is [{}], new level is [{}]", loggerConfiguration.getEffectiveLevel(), config.getLevel() );
                loggingSystem.setLogLevel(config.getLoggerName(), LogLevel.valueOf(config.getLevel()));
            }
        }
    }

    /**
     * 所有的日志级别
     * @return
     */
    private List<String> supportLevels() {
        return loggingSystem.getSupportedLogLevels().stream().map(Enum::name).collect(Collectors.toList());
    }
}
