package cloud.flystar.solon.dictionary.service.inner;

import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.framework.service.IBaseService;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
 * 字典服务
 */
public interface SysDictService extends IBaseService<SysDict> {
}
