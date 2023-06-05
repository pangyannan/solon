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
    SequenceSegmentEntity selectByBizAndLook(String bizCode,String loopCode);

    /**
     * 根据步长更新断的最大值
     * @param bizCode
     * @param loopCode
     * @param step
     * @return
     */
    SequenceSegmentEntity modifyMaxId(String bizCode,String loopCode, Integer step);

}
