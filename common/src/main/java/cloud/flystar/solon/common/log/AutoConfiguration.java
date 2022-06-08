package cloud.flystar.solon.common.log;


import cloud.flystar.solon.common.log.aspect.LogAspect;
import cloud.flystar.solon.common.log.audit.AuditLogAspect;
import cloud.flystar.solon.common.log.audit.AuditLogStoreImpl;
import cloud.flystar.solon.common.log.level.LogLevelService;
import cloud.flystar.solon.common.log.trace.HttpRequestTraceInterceptor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @Author: pangyannan
 * @Data: 2021/6/6
 * @Description: 日志配置类
 * 引入common-log-starter 自动配置
 * 如果不需要自动配置，或取消饮用，或配置 common.log.starter.open=false
 */
@Configuration
@ConditionalOnProperty(value = "common.log.starter.open",havingValue = "true",matchIfMissing = true)
@EnableAspectJAutoProxy
public class AutoConfiguration implements WebMvcConfigurer {


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
