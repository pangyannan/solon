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
     * 当前服务对应的数据资源对象，比如 /data/user
     * 一般是要和 ResourceInfo 中的定义一致的
     * 需要子类自行实现和定义
     * @return 当前服务的数据权限唯一键
     */
    String dataScopeKey();

    /**
     * 支持的权限过滤范围
     */
    List<DataScopeEnum> dataScopeTypes();

    /**
     * 获取当前用户的数据权限查询条件
     */
    Optional<Consumer<LambdaQueryWrapper<T>>> scopeQueryFilter();

    /**
     * 获取用户的数据权限查询条件
     * @param userId 用户ID
     */
    Optional<Consumer<LambdaQueryWrapper<T>>> scopeQueryFilter(Long userId);
}
