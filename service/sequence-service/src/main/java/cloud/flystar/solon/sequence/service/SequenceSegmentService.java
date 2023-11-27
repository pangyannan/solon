package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.sequence.service.dao.po.SequenceSegmentEntity;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * 流水号分段ID记录服务
 */
public interface SequenceSegmentService extends IService<SequenceSegmentEntity> {
    /**
     * 根据业务主键查询流水号分段记录
     * @param bizCode
     * @param loopCode
     * @return
     */
    SequenceSegmentEntity selectByBizAndLoop(String bizCode, String loopCode);


}
