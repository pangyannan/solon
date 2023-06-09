package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.sequence.service.dao.po.SequenceConfigEntity;
import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.service.IService;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;

/**
 * 流水号配置表服务
 */
public interface SequenceConfigService extends IService<SequenceConfigEntity> {
    SequenceConfigEntity getByBizCode(@NotBlank String bizCode);
}
