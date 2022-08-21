package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.log.trace.HttpRequestTraceInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 拦截器
 */
@Configuration
public class CoreWebMvcConfigurer implements WebMvcConfigurer {
    public static final int CORE_BASE_ORDER = 0;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // Trace拦截器
        registry.addInterceptor(new HttpRequestTraceInterceptor())
                .order(CORE_BASE_ORDER)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}
