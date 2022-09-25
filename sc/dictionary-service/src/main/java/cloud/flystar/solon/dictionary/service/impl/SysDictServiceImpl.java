package cloud.flystar.solon.dictionary.service.impl;

import cloud.flystar.solon.dictionary.service.SysDictService;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.dictionary.service.mapper.SysDictMapper;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class SysDictServiceImpl extends BaseServiceImpl<SysDictMapper, SysDict> implements SysDictService {
}
