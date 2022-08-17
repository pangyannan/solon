package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.crypto.PasswordEncoder;
import cloud.flystar.solon.commons.crypto.PasswordEncoderFactories;
import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import cloud.flystar.solon.commons.log.audit.Audit;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 登陆
 */
@Slf4j
@RestController
@RequestMapping("/login")
public class LoginController {

    @Resource
    private PasswordEncoder passwordEncoder;

    //默认登陆
//    @Audit(label = "默认用户名秘密登陆" ,paramLog = false)
    @GetMapping
    public Result<String> doLogin(String username, String password) {
        // 此处仅作模拟示例，真实项目需要从数据库中查询数据进行比对
        if("zhang".equals(username) && "123456".equals(password)) {
            StpUtil.logout(10001,"WEB");
            StpUtil.login(10001,"WEB");
            String tokenValue = StpUtil.getTokenValue();

            String encodePassword = passwordEncoder.encode(password);
            log.info(encodePassword);

            return Result.successBuild(tokenValue);
        }
        return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
    }

    //默认登陆
    @Audit(label = "默认用户名秘密登陆" ,paramLog = false)
    @GetMapping("/isLogin")
    public Result isLogin() {
        SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
        Object loginId = StpUtil.getLoginId();
        boolean login = StpUtil.isLogin();
        return Result.successBuild(tokenInfo);
    }


    public static void main(String[] args) {
        PasswordEncoder delegatingPasswordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
        String password = "123";
        String encode = delegatingPasswordEncoder.encode(password);
        boolean matches = delegatingPasswordEncoder.matches(password,encode);
        log.info("匹配结果"+matches);
    }
}
