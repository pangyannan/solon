package cloud.flystar.solon.framework.config;


import cloud.flystar.solon.commons.log.aspect.LogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogStore;
import cloud.flystar.solon.commons.log.audit.DefaultAuditLogStoreImpl;
import cloud.flystar.solon.commons.log.level.LogLevelService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.logging.LoggingSystem;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

/**
 * 日志配置类
 */
@Configuration
@EnableAspectJAutoProxy
public class LogConfig  {
    /**
     * 定义审计日志存储服务
     * @return
     */
    @Bean
    public AuditLogStore auditLogStore(){
        return new DefaultAuditLogStoreImpl();
    }

    /**
     * 定义日志切面
     * @return
     */
    @Bean
    public LogAspect webLogAopAspect(){
        return new LogAspect();
    }

    /**
     * 审计日志切面
     * @return
     */
    @Bean
    public AuditLogAspect auditLogAspect(AuditLogStore auditLogStore){
        return new AuditLogAspect(auditLogStore);
    }

    /**
     * 定义动态日志级别服务
     * @return
     */
    @Bean
    @ConditionalOnBean(LoggingSystem.class)
    public LogLevelService logLevelService(LoggingSystem loggingSystem){
        return new LogLevelService(loggingSystem);
    }
}
