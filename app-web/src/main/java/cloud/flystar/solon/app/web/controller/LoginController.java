package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.constant.YesOrNoEnum;
import cloud.flystar.solon.commons.crypto.PasswordEncoder;
import cloud.flystar.solon.commons.crypto.PasswordEncoderFactories;
import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import cloud.flystar.solon.commons.log.audit.Audit;
import cloud.flystar.solon.framework.config.SecureConfig;
import cloud.flystar.solon.user.api.UserAccountApi;
import cloud.flystar.solon.user.api.dto.UserAccountDto;
import cloud.flystar.solon.user.api.dto.UserLoginDto;
import cn.dev33.satoken.secure.SaSecureUtil;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Optional;

/**
 * 登陆
 */
@Slf4j
@RestController
@RequestMapping("/login")
public class LoginController {
    @Resource
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserAccountApi userAccountApi;

    @Autowired
    private SecureConfig secureConfig;

    //默认登陆
    @Audit(label = "默认用户名秘密登陆" ,paramLog = false)
    @PostMapping("/doLogin")
    public Result<String> doLogin(@RequestBody @Valid UserLoginDto userLoginDto) {
        UserAccountDto userAccountDto = userAccountApi.getBaseAccountByUserName(userLoginDto.getUserName());
        if(userAccountDto == null){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
        }

        if(Boolean.FALSE.equals(Optional.ofNullable(userAccountDto.getEnable()).orElse(Boolean.FALSE))){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0202);
        }
        if(Boolean.TRUE.equals(Optional.ofNullable(userAccountDto.getDeleteFlag()).orElse(Boolean.FALSE))){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0203);
        }

        //密码解密
        String privateKey = secureConfig.getPrivateKey();
        String realPassword = SaSecureUtil.rsaDecryptByPrivate(privateKey, userLoginDto.getPassword());
        if(StrUtil.isBlank(realPassword)){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
        }
        boolean passwordMatches = passwordEncoder.matches(realPassword, userAccountDto.getPassword());
        if(!passwordMatches){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
        }

        StpUtil.logout(userAccountDto.getUserId(),"WEB");
        StpUtil.login(userAccountDto.getUserId(),"WEB");
        String tokenValue = StpUtil.getTokenValue();
        return Result.successBuild(tokenValue);
    }

    //默认登陆
    @GetMapping("/encrypt/public")
    public Result<String> getEncode(String context) {
        String encryptByPublic = SaSecureUtil.rsaEncryptByPublic(secureConfig.getPublicKey(), context);
        return Result.successBuild(encryptByPublic);
    }


    public static void main(String[] args) throws Exception {
        PasswordEncoder delegatingPasswordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
        String password = "123";
        String encode = delegatingPasswordEncoder.encode(password);
        boolean matches = delegatingPasswordEncoder.matches(password,encode);
        log.info("匹配结果"+matches);

        System.out.println(SaSecureUtil.rsaGenerateKeyPair());
    }
}
