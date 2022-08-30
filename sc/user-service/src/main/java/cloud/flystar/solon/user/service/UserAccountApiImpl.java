package cloud.flystar.solon.user.service;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.bean.excetion.ErrorCodeEnum;
import cloud.flystar.solon.commons.crypto.PasswordEncoder;
import cloud.flystar.solon.framework.config.SecureConfig;
import cloud.flystar.solon.user.api.UserAccountApi;
import cloud.flystar.solon.user.api.dto.account.CaptchaImageResourceDto;
import cloud.flystar.solon.user.api.dto.account.UserAccountDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginSuccessToken;
import cloud.flystar.solon.user.service.convert.UserAccountDtoConvert;
import cloud.flystar.solon.user.service.entity.UserInfo;
import cn.dev33.satoken.secure.SaSecureUtil;
import cn.dev33.satoken.stp.SaTokenInfo;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.jwt.JWT;
import cn.hutool.jwt.JWTValidator;
import com.google.code.kaptcha.Producer;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.validation.constraints.NotBlank;
import java.awt.image.BufferedImage;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.TimeUnit;


@Service
public class UserAccountApiImpl implements UserAccountApi {
    @Resource
    private UserInfoService userInfoService;
    @Resource
    private UserAccountDtoConvert userAccountDtoConvert;
    @Resource
    private SecureConfig secureConfig;
    @Resource
    private PasswordEncoder passwordEncoder;
    @Resource
    private RedisTemplate redisTemplate;

    @Resource(name = "charProducer")
    private Producer charProducer;

    @Resource(name = "mathProducer")
    private Producer mathProducer;


    @Override
    public CaptchaImageResourceDto buildCaptchaImageResourceDto(String type) {

        String questionCode ;
        String expectCode;
        BufferedImage questionCodeImage;
        if(StrUtil.equals(type,"math")){
            String capText = mathProducer.createText();
            questionCode = capText.substring(0, capText.lastIndexOf("@"));
            questionCodeImage = mathProducer.createImage(questionCode);

            expectCode = capText.substring(capText.lastIndexOf("@") + 1);

        }else {
            questionCode = charProducer.createText();
            questionCodeImage = charProducer.createImage(questionCode);

            expectCode = questionCode;
        }

        //验证码结果加密
        String expectCodeEncrypt = SaSecureUtil.rsaEncryptByPrivate(secureConfig.getPrivateKey(),expectCode);

        //验证码放入JWT中
        Map<String,String> map = new HashMap<>();
        map.put("expectCodeEncrypt",expectCodeEncrypt);
        String captchaToken = JWT.create()
                .addHeaders(null)
                .addPayloads(map)
                //默认验证码1分钟过期
                .setExpiresAt(DateUtil.offsetMinute(DateUtil.date(),1))
                .setKey(secureConfig.getJwtKey().getBytes(StandardCharsets.UTF_8))
                .sign();

        CaptchaImageResourceDto dto = new CaptchaImageResourceDto();
        dto.setQuestionCode(questionCode);
        dto.setQuestionCodeImage(questionCodeImage);
        dto.setExpectCode(expectCode);
        dto.setExpectCodeEncrypt(expectCodeEncrypt);
        dto.setCaptchaToken(captchaToken);

        return dto;
    }

    /**
     * SaSecureUtil.rsaGenerateKeyPair 可以生成密钥对
     * @param userLoginDto
     * @return
     */
    @Override
    public Result<UserLoginSuccessToken> login(UserLoginDto userLoginDto) {
        //1.图形验证码验证
        Result result = this.captchaCodeCheck(userLoginDto);
        if(!result.getSuccess()){
            return result;
        }


        //2.用户禁用验证
        if(StpUtil.isDisable(userLoginDto.getUserName())){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0211);
        }

        //3.1查询用户
        String loginId;
        UserAccountDto userAccountDto;
        if(StrUtil.equals(GlobeConstant.ADMIN_USERNAME,userLoginDto.getUserName())){
            userAccountDto = new UserAccountDto();
            userAccountDto
                    .setUserId(0L)
                    .setUserName(userLoginDto.getUserName())
                    .setPassword(secureConfig.getAdminPassword())
                    .setEnable(Boolean.TRUE)
                    .setDeleteFlag(Boolean.FALSE);
            loginId = GlobeConstant.ADMIN_USERNAME;
        }else {
            userAccountDto = this.getBaseAccountByUserName(userLoginDto.getUserName());

            if (userAccountDto == null) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0210);
            }

            if (Boolean.FALSE == Optional.ofNullable(userAccountDto.getEnable()).orElse(Boolean.FALSE)) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0202);
            }
            if (Boolean.TRUE == Optional.ofNullable(userAccountDto.getDeleteFlag()).orElse(Boolean.FALSE)) {
                return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0203);
            }
            loginId = userAccountDto.getUserId().toString();
        }

        //3.2密码解密+验证
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

        //登陆成功处理
        StpUtil.login(loginId,userLoginDto.getLoginDevice());

        SaTokenInfo tokenInfo = StpUtil.getTokenInfo();
        UserLoginSuccessToken userLoginSuccessToken = this.convert(userAccountDto, tokenInfo);
        return Result.successBuild(userLoginSuccessToken);
    }

    @Override
    public UserAccountDto getBaseAccountByUserName(@NotBlank String userName) {
        UserInfo userInfo = userInfoService.getByUserName(userName);
        return userAccountDtoConvert.doForward(userInfo);
    }

    private void loginErrorRecord(UserAccountDto userAccountDto) {
        String errorNumCacheKey = GlobeConstant.REDIS_USER_PASSWORD_MATCHES_FAILED_PREFIX + userAccountDto.getUserName();
        if (redisTemplate.hasKey(errorNumCacheKey)) {
            Integer errorNum = (Integer) redisTemplate.opsForValue().get(errorNumCacheKey);
            if(errorNum < 10){
                redisTemplate.opsForValue().set(errorNumCacheKey, errorNum + 1, 60 * 10, TimeUnit.SECONDS);
            }else{
                StpUtil.disable(userAccountDto.getUserName(),60 * 10);
            }
        } else {
            redisTemplate.opsForValue().set(errorNumCacheKey, 1, 60 * 10, TimeUnit.SECONDS);
        }
    }

    private UserLoginSuccessToken convert(UserAccountDto userAccountDto, SaTokenInfo saTokenInfo){
        UserLoginSuccessToken userLoginSuccessToken = new UserLoginSuccessToken();
        userLoginSuccessToken.setUserId(userAccountDto.getUserId())
                .setUserName(userAccountDto.getUserName())
                .setTokenName(saTokenInfo.getTokenName())
                .setTokenValue(saTokenInfo.getTokenValue())
                .setTokenTimeout(saTokenInfo.getTokenTimeout())
                .setLoginDevice(saTokenInfo.getLoginDevice());
        return userLoginSuccessToken;
    }


    private Result captchaCodeCheck(UserLoginDto  userLoginDto){

        String captchaCode = userLoginDto.getCaptchaCode();
        String captchaToken = userLoginDto.getCaptchaToken();
        if(StrUtil.isBlank(captchaCode)){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0240);
        }
        if(StrUtil.isBlank(captchaToken)){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0240);
        }

        //JWT验证与解析
        JWT jwt = new JWT();
        jwt.setKey(secureConfig.getJwtKey().getBytes(StandardCharsets.UTF_8));
        jwt.parse(userLoginDto.getCaptchaToken());

        try {
            JWTValidator.of(jwt).validateDate(DateUtil.date(), 0);
        }catch (Exception e){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0244);
        }

        if(!jwt.verify()){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0240);
        }
        //解密结果
        String codeEncrypt = (String)jwt.getPayload("expectCodeEncrypt");
        String decryptStr = SaSecureUtil.rsaDecryptByPublic(secureConfig.getPublicKey(),codeEncrypt);


        //对比用户输入的结果
        if(!StrUtil.equals(decryptStr,userLoginDto.getCaptchaCode())){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0130);
        }

        return Result.successBuild();
    }
}
