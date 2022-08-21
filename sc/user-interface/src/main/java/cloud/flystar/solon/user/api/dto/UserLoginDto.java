package cloud.flystar.solon.user.api.dto;

/**
 * 用户登陆
 */

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class UserLoginDto {
   @NotBlank(message = "用户名不能为空")
   private String userName;
    @NotBlank(message = "密码不能为空")
    private String password;
}
