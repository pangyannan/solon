package cloud.flystar.solon.core.config;

import cloud.flystar.solon.commons.log.trace.HttpRequestTraceInterceptor;
import cloud.flystar.solon.core.interceptor.WebThreadLocalInterceptor;
import cn.dev33.satoken.interceptor.SaInterceptor;
import org.springframework.context.annotation.Configuration;
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
        //ThreadLocalInterceptor
        registry.addInterceptor(new WebThreadLocalInterceptor())
                .order(CORE_BASE_ORDER)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**");

        // Trace拦截器
        registry.addInterceptor(new HttpRequestTraceInterceptor())
                .order(CORE_BASE_ORDER + 10)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**");


        //sa登陆注解拦截器，有sa注解的拦截
        registry.addInterceptor(new SaInterceptor())
                .order(CoreWebMvcConfigurer.CORE_BASE_ORDER + 100)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**");

        // 注册 Sa-Token 拦截器，校验规则为 StpUtil.checkLogin() 登录校验。
//        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
//                .order(CoreWebMvcConfigurer.CORE_BASE_ORDER + 100)
//                .addPathPatterns("/**")
//                .excludePathPatterns("/user/doLogin");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}
