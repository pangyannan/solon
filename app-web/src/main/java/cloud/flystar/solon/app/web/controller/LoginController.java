package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.crypto.PasswordEncoder;
import cloud.flystar.solon.commons.crypto.PasswordEncoderFactories;
import cloud.flystar.solon.commons.log.audit.Audit;
import cloud.flystar.solon.framework.config.SecureConfig;
import cloud.flystar.solon.user.api.UserAccountApi;
import cloud.flystar.solon.user.api.dto.account.CaptchaImageResourceDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginSuccessToken;
import cn.dev33.satoken.secure.SaSecureUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * 登陆
 */
@Slf4j
@Controller
@RequestMapping("/login")
public class LoginController {
    @Resource
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserAccountApi userAccountApi;

    @Autowired
    private SecureConfig secureConfig;

    @Autowired
    private RedisTemplate redisTemplate;

    @GetMapping({""})
    public String saLogin(HttpServletRequest request) {
        return "sa-login.html";
    }

    /**
     * 验证码生成
     */
    @GetMapping(value = "/captcha")
    public void image(@RequestParam(name = "type" ,defaultValue = "math") String type
            , HttpServletResponse response) throws IOException {
        CaptchaImageResourceDto captchaImageResourceDto = userAccountApi.buildCaptchaImageResourceDto(type);

        BufferedImage image = captchaImageResourceDto.getQuestionCodeImage();
        //设置头，输出格式与不缓存
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");
        response.setHeader("captchaToken",captchaImageResourceDto.getCaptchaToken());

        ServletOutputStream outputStream = response.getOutputStream();
        //使用ImageIO向前端输出图片
        ImageIO.write(image,"jpeg",outputStream);
    }

    //默认登陆
    @Audit(label = "默认用户名秘密登陆" ,paramLog = true)
    @PostMapping("/doLogin")
    public Result<UserLoginSuccessToken> doLogin(@RequestBody @Valid UserLoginDto userLoginDto) {
        userLoginDto.setLoginDevice(GlobeConstant.PROJECT_CODE_WEB);
        return userAccountApi.login(userLoginDto);
    }

    //默认登陆
    @GetMapping("/encrypt/public")
    public Result<String> getEncode(String context)  {
        String encryptByPublic = SaSecureUtil.rsaEncryptByPublic(secureConfig.getPublicKey(), context);
        return Result.successBuild(encryptByPublic);
    }


    public static void main(String[] args) throws Exception {
        PasswordEncoder delegatingPasswordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
        String password = "1234567";
        String encode = delegatingPasswordEncoder.encode(password);
        log.info("密码加密："+encode);

        boolean matches = delegatingPasswordEncoder.matches(password,encode);
        log.info("匹配结果："+matches);

        System.out.println(SaSecureUtil.rsaGenerateKeyPair());
    }
}
