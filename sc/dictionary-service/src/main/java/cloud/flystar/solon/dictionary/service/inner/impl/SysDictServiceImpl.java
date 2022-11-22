package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.dictionary.service.inner.SysDictService;
import cloud.flystar.solon.dictionary.service.mapper.SysDictMapper;
import cloud.flystar.solon.framework.service.FrameworkContextService;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.api.dto.DataScopeEnum;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;

@Slf4j
@Service
public class SysDictServiceImpl extends BaseServiceImpl<SysDictMapper, SysDict> implements SysDictService {


    @Override
    public IPage<SysDict> pageByDataScope(IPage<SysDict> page, LambdaQueryChainWrapper<SysDict> queryWrapper) {

        Consumer<LambdaQueryWrapper<SysDict>> consumer = this.consumer();
        if(consumer != null){
            queryWrapper.and(consumer);
        }
        return super.page(page,queryWrapper.getWrapper());
    }


    private Consumer<LambdaQueryWrapper<SysDict>> consumer(){
        List<DataScopeEnum> dataScopeEnum = this.getDataScopeEnum();
        if(CollectionUtil.isEmpty(dataScopeEnum)){
            return null;
        }


        if(dataScopeEnum.contains(DataScopeEnum.ALL)){
            return null;
        }

        List<DataScopeEnum> list = dataScopeEnum.stream().filter(t -> t != DataScopeEnum.ALL).collect(Collectors.toList());
        if(CollectionUtil.isEmpty(list)){
            return null;
        }

        //未来数据权限框架抽离出去，各服务自己实现最基本的方法即可，比如 SysDict::getCreateUserId，SysDict::getDeptId
        Consumer<LambdaQueryWrapper<SysDict>> consumer = queryChainWrapper ->{
            for (int i = 0; i < list.size(); i++) {
                DataScopeEnum scopeEnum = list.get(i);
                if(scopeEnum  == DataScopeEnum.DEPT_CHILD){
                    queryChainWrapper.or(i > 0 ).in(SysDict::getCreateUserId,this.getDeptAndChild());//下级部门
                }

                if(scopeEnum  == DataScopeEnum.DEPT_CURRENT){
                    queryChainWrapper.or(i > 0 ).in(SysDict::getCreateUserId,this.getDept());//本部门
                }

                if(scopeEnum  == DataScopeEnum.CREATOR){
                    queryChainWrapper.or(i > 0 ).eq(SysDict::getCreateUserId,0L);//当前登陆人
                }
            }
        };
        return consumer;
    }

    private List<Long> getDept() {
        return ListUtil.toList(0L);
    }

    /**
     * 获取当前用户的数据权限集合
     * @return
     */
    private List<DataScopeEnum> getDataScopeEnum(){
//        Long loginId = frameworkContextService.get();
//        if(loginId == null){
//            return ListUtil.empty();
//        }
        return ListUtil.toList(DataScopeEnum.values());
    }

    /**
     * 模拟查询当前用户的部门以及子部门
     * @return
     */
    private List<Long> getDeptAndChild(){
        return ListUtil.toList(0L,1L);
    }
}
