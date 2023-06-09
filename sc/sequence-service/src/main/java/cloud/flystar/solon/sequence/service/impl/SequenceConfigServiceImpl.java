package cloud.flystar.solon.sequence.service.impl;

import cloud.flystar.solon.sequence.service.SequenceConfigService;
import cloud.flystar.solon.sequence.service.dao.mapper.SequenceConfigMapper;
import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;


@Slf4j
@Service
@Validated
public class SequenceConfigServiceImpl extends ServiceImpl<SequenceConfigMapper, SequenceConfigEntity> implements SequenceConfigService{
    @Override
    public SequenceConfigEntity getByBizCode(@NotBlank String bizCode) {
        return this.lambdaQuery().eq(SequenceConfigEntity::getBizCode,bizCode).one();
    }
}
