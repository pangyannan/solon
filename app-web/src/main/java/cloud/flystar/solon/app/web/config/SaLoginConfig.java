package cloud.flystar.solon.app.web.config;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.filter.SaServletFilter;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

import java.util.Arrays;
import java.util.List;

@Configuration
public class SaLoginConfig {
    //不用登陆的地址
    private List<String> excludeList = Arrays.asList(
            "/*.ico", "/js/**","/css/**","/lib/**",
            "/login", "/doLogin");

    @Bean
    @Order(-101)
    public SaServletFilter getSaServletFilter() {
        SaServletFilter saServletFilter = new SaServletFilter();
        saServletFilter
                .addInclude("/**")
                .setExcludeList(excludeList)
                .setAuth(auth ->{
                    if (!StpUtil.isLogin()) {
                        SaHolder.getRequest().forward("/login");
                        SaRouter.back();
                    }})
                .setError((e -> e.getMessage()));
        return saServletFilter;
    }
}
