package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import com.baomidou.mybatisplus.extension.service.IService;

import javax.validation.constraints.NotBlank;

/**
 * 流水号配置表服务
 */
public interface SequenceConfigService extends IService<SequenceConfigEntity> {
    SequenceConfigEntity getByBizCode(@NotBlank String bizCode);
}
