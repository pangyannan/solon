package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.commons.bean.constant.DataScopeEnum;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260AreaLevelEnum;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2260Service;
import cloud.flystar.solon.dictionary.service.mapper.MdmGbT2260Mapper;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;
import java.util.function.Consumer;
import java.util.stream.Collectors;

@Slf4j
@Service
public class MdmGbT2260ServiceImpl extends BaseServiceImpl<MdmGbT2260Mapper, MdmGbT2260> implements MdmGbT2260Service {
    @Resource
    private MdmGbT2260DataScope mdmGbT2260DataScope;

    @Override
    public List<MdmGbT2260> listProvince() {
        return this.lambdaQuery().eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.Province.getCode()).list();
    }

    @Override
    public List<MdmGbT2260> listCityByProvinceCode(String provincesCode) {
        if(StrUtil.isBlank(provincesCode)){
            return ListUtil.empty();
        }
        return this.lambdaQuery()
                .eq(MdmGbT2260::getParentCode,provincesCode)
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.City.getCode()).list();
    }

    @Override
    public List<MdmGbT2260> listDistrictByCityCode(String cityCode) {
        if(StrUtil.isBlank(cityCode)){
            return ListUtil.empty();
        }
        return this.lambdaQuery()
                .eq(MdmGbT2260::getParentCode,cityCode)
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.District.getCode()).list();
    }

    @Override
    public Page<MdmGbT2260> pageByDataScope(Page<MdmGbT2260> page, LambdaQueryChainWrapper<MdmGbT2260> queryWrapper) {

//        Consumer<LambdaQueryWrapper<MdmGbT2260>> consumer = this.consumer();
//        if(consumer != null){
//            queryWrapper.and(consumer);
//        }
        Optional<Consumer<LambdaQueryWrapper<MdmGbT2260>>> optional = mdmGbT2260DataScope.scopeQuery(1L);
        optional.ifPresent(t -> queryWrapper.and(optional.get()));
        return super.page(page,queryWrapper.getWrapper());
    }


    private Consumer<LambdaQueryWrapper<MdmGbT2260>> consumer(){
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
        Consumer<LambdaQueryWrapper<MdmGbT2260>> consumer = queryChainWrapper ->{
            for (int i = 0; i < list.size(); i++) {
                DataScopeEnum scopeEnum = list.get(i);
                if(scopeEnum  == DataScopeEnum.DEPT_CHILD){
                    queryChainWrapper.or(i > 0 ).in(MdmGbT2260::getAreaCode,this.getDeptAndChild());//下级部门
                }

                if(scopeEnum  == DataScopeEnum.DEPT_CURRENT){
                    queryChainWrapper.or(i > 0 ).in(MdmGbT2260::getAreaLevel,this.getDept());//本部门
                }

                if(scopeEnum  == DataScopeEnum.CREATOR){
                    queryChainWrapper.or(i > 0 ).eq(MdmGbT2260::getParentCode,100L);//当前登陆人
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
        return ListUtil.toList(DataScopeEnum.DEPT_CHILD,DataScopeEnum.CREATOR);
    }

    /**
     * 模拟查询当前用户的部门以及子部门
     * @return
     */
    private List<Long> getDeptAndChild(){
        return ListUtil.toList(0L,1L,2L,4L);
    }


}
