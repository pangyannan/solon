package cloud.flystar.solon.core.service;

import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.Collection;

/**
 * 基于mybatis-plus二次封装的服务
 */
public interface IBaseService<T> extends IService<T> {
    /**
     * 批量更新或新增或删除
     * 一般用于 子表 一次性保存时
     * @param entityList 待保存的数据
     * @param parentField 父表关联主键属性
     * @param parentFieldValue 父表关联主键属性值
     * @param <R>
     * @return
     */
    <R>  boolean saveOrUpdateByParentField(Collection<T> entityList, SFunction<T,R> parentField,R parentFieldValue);
}
