package cloud.flystar.solon.framework.config;


import cloud.flystar.solon.commons.log.aspect.LogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogAspect;
import cloud.flystar.solon.commons.log.audit.AuditLogStoreImpl;
import cloud.flystar.solon.commons.log.level.LogLevelService;
import cloud.flystar.solon.commons.log.trace.HttpRequestTraceInterceptor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 日志配置类
 */
@Configuration
@EnableAspectJAutoProxy
public class LogConfig implements WebMvcConfigurer {


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册拦截器
        registry.addInterceptor(new HttpRequestTraceInterceptor()).addPathPatterns("/**");
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
