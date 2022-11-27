package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.commons.bean.constant.DataScopeEnum;
import cloud.flystar.solon.commons.bean.dto.user.UserDataResourceScope;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.framework.service.FrameworkContextService;
import cloud.flystar.solon.framework.service.UserDataScopeService;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.ISqlSegment;
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
     * 当前服务对应的数据资源对象，比如 /data/user
     * 一般是要和 ResourceInfo 中的定义一致的
     * 需要子类自行实现和定义
     * @return
     */
    protected abstract String dataScopeKey();

    /**
     * 保证查询条件一定为false的实现
     * 例如 return queryChainWrapper -> queryChainWrapper.eq(User::getUserId,-1);
     * @param userId
     * @return
     */
    protected abstract Consumer<LambdaQueryWrapper<T>> assertFalse(Long userId);


    @Override
    public List<DataScopeEnum> supportDataScopeEnum() {
        return ListUtil.toList(DataScopeEnum.values());
    }

    @Override
    public Optional<Consumer<LambdaQueryWrapper<T>>> scopeQuery(Long userId){
        //如果当前未实现任何权限类型定义，则直接返回
        List<DataScopeEnum> supportDataScopeEnums = this.supportDataScopeEnum();
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
            return Optional.of(this.assertFalse(userId));
        }
        if(userDataScopeEnum.contains(DataScopeEnum.ALL)){
            return this.all(userId);
        }

        UserSessionInfo userSessionInfo = userSessionInfoOptional.get();
        List<DataScopeEnum> list = userDataScopeEnum.stream().filter(t -> t != DataScopeEnum.ALL).collect(Collectors.toList());

        //如果没有其他数据范围的权限，直接返回一个一定为false的条件
        if(CollectionUtil.isEmpty(list)){
            return Optional.of(this.assertFalse(userId));
        }

        Consumer<LambdaQueryWrapper<T>> consumer = queryChainWrapper ->{
            for (int i = 0; i < list.size(); i++) {
                DataScopeEnum scopeEnum = list.get(i);
                if(DataScopeEnum.DEPT_CHILD == scopeEnum
                        && supportDataScopeEnums.contains(scopeEnum)
                        && this.deptChild() != null ){
                    if(CollectionUtil.isNotEmpty(userSessionInfo.getManagementDeptIds())){
                        queryChainWrapper.or(i > 0 ).in(this.deptChild(),userSessionInfo.getManagementDeptIds());
                    }
                }

                if(DataScopeEnum.DEPT_CURRENT == scopeEnum
                        && this.supportDataScopeEnum().contains(scopeEnum)
                        && this.deptChild() != null){
                    if(CollectionUtil.isNotEmpty(userSessionInfo.getDeptIds())){
                        queryChainWrapper.or(i > 0 ).in(this.deptCurrent(),userSessionInfo.getDeptIds());
                    }
                }

                if(DataScopeEnum.CREATOR == scopeEnum
                        && supportDataScopeEnums.contains(scopeEnum)
                        && this.creator() != null){
                    queryChainWrapper.or(i > 0 ).eq(this.creator(),userSessionInfo.getUserId());
                }
            }
        };
        return Optional.of(consumer);
    }

    /**
     * 获取当前数据资源对象的数据权限
     */
    protected  List<DataScopeEnum> getUserDataScopeEnum(Long userId){
        Optional<UserSessionInfo> optional = frameworkContextService.getUserSessionInfoDefaultNull(2L);
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
     * 默认如果为全部，则无需限制查询条件
     * @param userId
     * @return
     */
    protected Optional<Consumer<LambdaQueryWrapper<T>>> all(Long userId){
        return Optional.empty();
    }

    protected SFunction<T, ?> deptChild(){
        return null;
    }

    protected SFunction<T, ?> deptCurrent( ){
        return null;
    }

    protected SFunction<T, ?> creator( ){
        return null;
    }




    public static class EmptyDataScopesISqlSegment implements ISqlSegment {
        private String sqlSegment;

        public EmptyDataScopesISqlSegment(String sqlSegment) {
            this.sqlSegment = sqlSegment;
        }

        @Override
        public String getSqlSegment() {
            return sqlSegment;
        }
    }
}
