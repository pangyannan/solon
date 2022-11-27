package cloud.flystar.solon.framework.service;

import cloud.flystar.solon.commons.bean.constant.DataScopeEnum;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;

/**
 * 用户数据权限服务
 */
public interface UserDataScopeService<T> {
    /**
     * 支持的权限顾虑范围
     * @return
     */
    List<DataScopeEnum> supportDataScopeEnum();
    /**
     * 获取用户的数据权限查询条件
     * @param userId
     * @return
     */
    Optional<Consumer<LambdaQueryWrapper<T>>> scopeQuery(Long userId);
}
