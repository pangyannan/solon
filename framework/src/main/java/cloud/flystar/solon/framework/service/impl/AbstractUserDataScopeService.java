package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.commons.bean.constant.DataScopeEnum;
import cloud.flystar.solon.commons.bean.dto.user.UserDataResourceScope;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.framework.service.FrameworkContextService;
import cloud.flystar.solon.framework.service.UserDataScopeService;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.stream.Collectors;


public abstract class AbstractUserDataScopeService<T> implements UserDataScopeService<T> {
    @Resource
    FrameworkContextService frameworkContextService;

    /**
     * 保证查询条件一定为false的实现
     * 一般是用于用户没有数据权限时的条件
     * @param userId 用户id
     * @return 例如 return queryChainWrapper -> queryChainWrapper.eq(User::getUserId,-1);
     */
    protected abstract Consumer<LambdaQueryWrapper<T>> assertFilterFalse(Long userId);


    @Override
    public List<DataScopeEnum> dataScopeTypes() {
        return ListUtil.toList(DataScopeEnum.values());
    }

    @Override
    public Optional<Consumer<LambdaQueryWrapper<T>>> scopeQueryFilter() {
        Long loginId = frameworkContextService.getLoginIdDefaultNull();
        return this.scopeQueryFilter(loginId);
    }

    @Override
    public Optional<Consumer<LambdaQueryWrapper<T>>> scopeQueryFilter(Long userId){
        //如果当前未实现任何权限类型定义，则直接返回
        List<DataScopeEnum> supportDataScopeEnums = this.dataScopeTypes();
        if(CollectionUtil.isEmpty(supportDataScopeEnums)){
            return Optional.empty();
        }

        Optional<UserSessionInfo> userSessionInfoOptional = frameworkContextService.getUserSessionInfoDefaultNull(userId);
        if(!userSessionInfoOptional.isPresent()){
            //如果当前没有用户信息，不限制
            return Optional.empty();
        }



        List<DataScopeEnum> userDataScopeEnum = this.getUserDataScopeEnum(userId);
        //如果没有数据权限范围，直接返回一个一定为false的条件
        if(CollectionUtil.isEmpty(userDataScopeEnum)){
            return Optional.of(this.assertFilterFalse(userId));
        }
        if(userDataScopeEnum.contains(DataScopeEnum.ALL)){
            return this.all(userId);
        }

        UserSessionInfo userSessionInfo = userSessionInfoOptional.get();
        List<DataScopeEnum> list = userDataScopeEnum.stream().filter(t -> t != DataScopeEnum.ALL).collect(Collectors.toList());

        //如果没有其他数据范围的权限，直接返回一个一定为false的条件
        if(CollectionUtil.isEmpty(list)){
            return Optional.of(this.assertFilterFalse(userId));
        }

        Consumer<LambdaQueryWrapper<T>> consumer = queryChainWrapper ->{
            for (int i = 0; i < list.size(); i++) {
                DataScopeEnum scopeEnum = list.get(i);
                if(DataScopeEnum.DEPT_CHILD == scopeEnum
                        && supportDataScopeEnums.contains(scopeEnum)
                        && this.getDataOwnerDept() != null ){
                    if(CollectionUtil.isNotEmpty(userSessionInfo.getManagementDeptIds())){
                        queryChainWrapper.or(i > 0 ).in(this.getDataOwnerDept(),userSessionInfo.getManagementDeptIds());
                    }
                }

                if(DataScopeEnum.DEPT_CURRENT == scopeEnum
                        && this.dataScopeTypes().contains(scopeEnum)
                        && this.getDataOwnerDept() != null){
                    if(CollectionUtil.isNotEmpty(userSessionInfo.getDeptIds())){
                        queryChainWrapper.or(i > 0 ).in(this.getDataOwnerDept(),userSessionInfo.getDeptIds());
                    }
                }

                if(DataScopeEnum.CREATOR == scopeEnum
                        && supportDataScopeEnums.contains(scopeEnum)
                        && this.getDataOwnerUser() != null){
                    queryChainWrapper.or(i > 0 ).eq(this.getDataOwnerUser(),userSessionInfo.getUserId());
                }
            }
        };
        return Optional.of(consumer);
    }

    /**
     * 获取当前数据资源对象的数据权限
     */
    protected  List<DataScopeEnum> getUserDataScopeEnum(Long userId){
        Optional<UserSessionInfo> optional = frameworkContextService.getUserSessionInfoDefaultNull(userId);
        if(!optional.isPresent()){
            return ListUtil.empty();
        }
        UserSessionInfo userSessionInfo = optional.get();
        List<UserDataResourceScope> userDataResourceScopes = userSessionInfo.getUserDataResourceScopes();
        if(CollectionUtil.isEmpty(userDataResourceScopes)){
            return ListUtil.empty();
        }

        Optional<UserDataResourceScope> first = userDataResourceScopes.stream().filter(t -> StrUtil.equals(t.getDataResourceKey(), this.dataScopeKey())).findFirst();
        if(!first.isPresent()){
            return ListUtil.empty();
        }
        UserDataResourceScope userDataResourceScope = first.get();
        List<String> dataScopeCodes = userDataResourceScope.getDataScopeCodes();
        return DataScopeEnum.getByCodes(dataScopeCodes);
    }


    /**
     * 如果用户所有权限，则返回空的无需过滤的条件
     * @param userId 用户id
     * @return 空的无需过滤的条件表达式
     */
    protected Optional<Consumer<LambdaQueryWrapper<T>>> all(Long userId){
        return Optional.empty();
    }

    /**
     * 数据权属部门列
     * 按照约定大于配置的思想，建议所有的权属部门字段命名全部统一为：data_owner_dept, 并且是单部门属性值
     * @return 例如 User::getDataOwnerDept
     */
    protected SFunction<T, ?> getDataOwnerDept(){
        return null;
    }

    /**
     * 数据权属人数据列
     * 按照约定大于配置的思想，建议所有的权属部门字段命名全部统一为：data_owner_user, 并且是单人员属性
     * @return 例如 User::getDataOwnerDept
     */
    protected SFunction<T, ?> getDataOwnerUser( ){
        return null;
    }
}
