package cloud.flystar.solon.app.web.config;

import cloud.flystar.solon.framework.config.CoreWebMvcConfigurer;
import cn.dev33.satoken.interceptor.SaAnnotationInterceptor;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@AutoConfigureAfter(CoreWebMvcConfigurer.class)
public class SaTokenConfigure implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册 Sa-Token 的路由拦截器
//        registry.addInterceptor(new SaRouteInterceptor())
//                .addPathPatterns("/**")
//                .excludePathPatterns("/user/doLogin","/error");

        // 注册注解拦截器，并排除不需要注解鉴权的接口地址 (与登录拦截器无关)
        // 注册Sa-Token的注解拦截器，打开注解式鉴权功能
        registry.addInterceptor(new SaAnnotationInterceptor())
                .order(CoreWebMvcConfigurer.CORE_BASE_ORDER + 100)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**");
    }
}
