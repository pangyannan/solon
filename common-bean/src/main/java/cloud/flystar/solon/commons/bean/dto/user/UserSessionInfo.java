package cloud.flystar.solon.commons.bean.dto.user;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.List;

/**
 * 用户登陆后相关信息（用户维度）
 */
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

    /**
     * 用户当前部门列表
     */
    private List<Long> deptIds;

    /**
     * 当前用户所管理的部门
     */
    private List<Long> managementDeptIds;

    /**
     * 数据返回权限
     */
    private List<UserDataResourceScope> userDataResourceScopes;

}
