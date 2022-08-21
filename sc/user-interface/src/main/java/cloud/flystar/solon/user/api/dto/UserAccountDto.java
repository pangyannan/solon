package cloud.flystar.solon.user.api.dto;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 用户账号
 */
@Data
@Accessors(chain = true)
public class UserAccountDto {
    /** 用户ID */
    private Long userId;

    /** 登陆账号 */
    private String userName;

    /** 密码 */
    private String password;



    /** 帐号状态（false 禁用 true启用） */
    private Boolean enable;

    /** 删除标志（false 代表未删除 true代表删除）*/
    private Boolean deleteFlag;
}
