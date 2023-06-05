package cloud.flystar.solon.sequence.service.impl;

import cloud.flystar.solon.sequence.service.SequenceConfigService;
import cloud.flystar.solon.sequence.service.dao.mapper.SequenceConfigMapper;
import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class SequenceConfigServiceImpl extends ServiceImpl<SequenceConfigMapper, SequenceConfigEntity> implements SequenceConfigService{
}
