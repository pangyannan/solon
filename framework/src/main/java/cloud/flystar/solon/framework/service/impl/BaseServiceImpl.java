package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.framework.service.IBaseService;
import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import com.baomidou.mybatisplus.core.toolkit.Assert;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class BaseServiceImpl<M extends BaseMapper<T>, T> extends ServiceImpl<M,T> implements IBaseService<T> {
    @Override
    @Transactional(rollbackFor = Exception.class)
    public <R> boolean saveOrUpdateByParentField(Collection<T> entityList, SFunction<T, R> parentGetFunction, final R parentFieldValue) {
        long count = entityList.stream().map(parentGetFunction).filter(t -> !parentFieldValue.equals(t)).count();
        Assert.isTrue(count == 0, "error: entityList 中父属性不唯一 , 请检查数据或程序");

        TableInfo tableInfo = TableInfoHelper.getTableInfo(this.entityClass);
        String keyProperty = tableInfo.getKeyProperty();

        //数据库中已经存在的数据
        List<T> existsList = this.lambdaQuery().eq(parentGetFunction, parentFieldValue).list();
        List<Serializable> existsIds = existsList.stream().map(t -> (Serializable) tableInfo.getPropertyValue(t, keyProperty)).collect(Collectors.toList());

        //待保存的数据
        List<Serializable> saveIds = entityList.stream().map(t -> (Serializable) tableInfo.getPropertyValue(t, keyProperty))
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        // existsList有 , saveIds 没有，表示要删除的数据
        Collection<Serializable> deleteIds = CollectionUtil.subtract(existsIds, saveIds);
        if(CollectionUtil.isNotEmpty(deleteIds)){
            this.removeByIds(deleteIds);
        }

        //有ID的新增
        List<T> saveList = entityList.stream().filter(t -> tableInfo.getPropertyValue(t, keyProperty) != null).collect(Collectors.toList());
        if(CollectionUtil.isNotEmpty(saveList)){
            this.saveBatch(saveList);
        }


        //没有ID的修改
        List<T> updateList = entityList.stream().filter(t -> tableInfo.getPropertyValue(t, keyProperty) == null).collect(Collectors.toList());
        if(CollectionUtil.isNotEmpty(updateList)){
            this.updateBatchById(updateList);
        }

        return true;
    }
}
