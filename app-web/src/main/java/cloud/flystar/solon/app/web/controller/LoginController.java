package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.app.web.constant.GlobeConstant;
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
import cn.dev33.satoken.session.SaSession;
import cn.dev33.satoken.session.SaSessionCustomUtil;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.Optional;
import java.util.concurrent.TimeUnit;

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

    @Autowired
    private RedisTemplate redisTemplate;

    //默认登陆
    @Audit(label = "默认用户名秘密登陆" ,paramLog = false)
    @PostMapping("/doLogin")
    public Result<SaTokenInfo> doLogin(@RequestBody @Valid UserLoginDto userLoginDto) {
        String errorNumCacheKey = GlobeConstant.REDIS_USER_PASSWORD_MATCHES_FAILED_PREFIX + userLoginDto.getUserName();
        if(redisTemplate.hasKey(errorNumCacheKey)) {
            // 登录时候先判断是否有登录错误的计数
            Integer errorNum = (Integer) redisTemplate.opsForValue().get(errorNumCacheKey);
            if(errorNum >= 10){
                 return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0211);
            }
        }


        String loginId;
        UserAccountDto userAccountDto;
        if(StrUtil.equals(GlobeConstant.ADMIN_USERNAME,userLoginDto.getUserName())){
            userAccountDto = new UserAccountDto();
            userAccountDto.setUserName(userLoginDto.getUserName())
                    .setPassword(secureConfig.getAdminPassword())
                    .setEnable(Boolean.TRUE)
                    .setDeleteFlag(Boolean.FALSE);
            loginId = GlobeConstant.ADMIN_USERNAME;
        }else {
            userAccountDto = userAccountApi.getBaseAccountByUserName(userLoginDto.getUserName());

            if (userAccountDto == null) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
            }

            if (Boolean.FALSE.equals(Optional.ofNullable(userAccountDto.getEnable()).orElse(Boolean.FALSE))) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0202);
            }
            if (Boolean.TRUE.equals(Optional.ofNullable(userAccountDto.getDeleteFlag()).orElse(Boolean.FALSE))) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0203);
            }
            loginId = userAccountDto.getUserId().toString();
        }

        //密码解密
        String privateKey = secureConfig.getPrivateKey();
        String realPassword = SaSecureUtil.rsaDecryptByPrivate(privateKey, userLoginDto.getPassword());
        if(StrUtil.isBlank(realPassword)){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
        }
        boolean passwordMatches = passwordEncoder.matches(realPassword, userAccountDto.getPassword());
        if(!passwordMatches){
            loginErrorRecord(userAccountDto);
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
        }

        StpUtil.logout(loginId,GlobeConstant.PROJECT_CODE);
        StpUtil.login(loginId,GlobeConstant.PROJECT_CODE);


        SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
        return Result.successBuild(tokenInfo);
    }

    //默认登陆
    @GetMapping("/encrypt/public")
    public Result<String> getEncode(String context) {
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


    private void loginErrorRecord(UserAccountDto userAccountDto) {
        String errorNumCacheKey = GlobeConstant.REDIS_USER_PASSWORD_MATCHES_FAILED_PREFIX + userAccountDto.getUserName();
        if (redisTemplate.hasKey(errorNumCacheKey)) {
            Integer errorNum = (Integer) redisTemplate.opsForValue().get(errorNumCacheKey);
            redisTemplate.opsForValue().set(errorNumCacheKey, errorNum + 1, 60 * 10, TimeUnit.SECONDS);
        } else {
            redisTemplate.opsForValue().set(errorNumCacheKey, 1, 60 * 10, TimeUnit.SECONDS);
        }
    }

}
