package cloud.flystar.solon.user.api.dto.account;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 用户登陆成功结果
 */
@Data
@Accessors(chain = true)
public class UserLoginSuccessToken {
    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户名不能为空
      */
    private String userName;


    /** token名称 */
    public String tokenName;

    /** token值 */
    public String tokenValue;

    /** token剩余有效期 (单位: 秒) */
    public long tokenTimeout;


    /** 登录设备类型 */
    public String loginDevice;

}
