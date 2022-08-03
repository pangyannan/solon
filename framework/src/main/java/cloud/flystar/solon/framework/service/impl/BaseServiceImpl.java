package cloud.flystar.solon.framework.service.impl;

import cloud.flystar.solon.framework.service.IBaseService;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

public class BaseServiceImpl<M extends BaseMapper<T>, T> extends ServiceImpl<M,T> implements IBaseService<T> {
}
