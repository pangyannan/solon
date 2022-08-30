package cloud.flystar.solon.user.api;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.user.api.dto.account.CaptchaImageResourceDto;
import cloud.flystar.solon.user.api.dto.account.UserAccountDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginDto;
import cloud.flystar.solon.user.api.dto.account.UserLoginSuccessToken;

import javax.validation.constraints.NotBlank;

/**
 * 用户账号服务
 */
public interface UserAccountApi {
    /**
     * 生成图形验证码
     * @param type  math数学表达式 其他：字符串
     * @return
     */
    CaptchaImageResourceDto buildCaptchaImageResourceDto(String type);
    /**
     * 用户登陆
     * @param userLoginDto
     * @return
     */
    Result<UserLoginSuccessToken> login(UserLoginDto userLoginDto);
    /**
     * 根据用户名查询账号基本
     * @param userName
     * @return
     */
    UserAccountDto getBaseAccountByUserName(@NotBlank String userName);
}
