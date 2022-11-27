package cloud.flystar.solon.commons.bean.dto.user;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 用户登陆后token信息（每个token维度）
 */
@Data
@Accessors(chain = true)
public class UserTokenSessionInfo {
    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户名不能为空
     */
    private String userName;

    private String ip;
}
