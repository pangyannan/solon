package cloud.flystar.solon.commons.bean.dto.user;

import cloud.flystar.solon.commons.bean.constant.DataScopeEnum;
import lombok.Data;

import java.util.List;

/**
 * 数据对象权限范围
 */
@Data
public class UserDataResourceScope {
    /**
     * 数据对象
     */
    private String dataResourceKey;

    /**
     * 数据对象权限返回
     * @see DataScopeEnum
     */
    private List<String> dataScopeCodes;
}
