package cloud.flystar.solon.user.api.dto.account;

/**
 * 用户登陆
 */

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class UserLoginDto {
    @NotBlank(message = "用户名不能为空")
    private String userName;

    /**
     * 前端传输密码必须用publicKey进行加密
     */
    @NotBlank(message = "密码不能为空")
    private String password;

    /**
     * 登陆设备类型
     */
    private String loginDevice;


    /**
     * 图形验证码Token
     */
    private String captchaToken;
    /**
     * 图形验证码结果
     */
    private String captchaCode;
}
