package cloud.flystar.solon.commons.bean.dto.user;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserSessionInfo {
    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户名不能为空
     */
    private String userName;
}
