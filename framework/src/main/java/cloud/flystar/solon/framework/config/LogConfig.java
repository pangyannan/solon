package cloud.flystar.solon.framework.config;


import cloud.flystar.solon.commons.log.aspect.LogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogStoreImpl;
import cloud.flystar.solon.commons.log.level.LogLevelService;
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
    public AuditLogAspect auditLogAspect(){
        return new AuditLogAspect(new AuditLogStoreImpl());
    }

    /**
     * 定义动态日志级别服务
     * @return
     */
    @Bean
    public LogLevelService logLevelService(){
        return new LogLevelService();
    }
}
