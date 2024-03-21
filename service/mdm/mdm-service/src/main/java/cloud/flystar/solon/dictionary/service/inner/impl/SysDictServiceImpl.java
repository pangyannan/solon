package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.core.service.impl.BaseServiceImpl;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.dictionary.service.inner.SysDictService;
import cloud.flystar.solon.dictionary.service.mapper.SysDictMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class SysDictServiceImpl extends BaseServiceImpl<SysDictMapper, SysDict> implements SysDictService {
}
