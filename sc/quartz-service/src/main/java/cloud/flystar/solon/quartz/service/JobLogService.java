package cloud.flystar.solon.quartz.service;

import cloud.flystar.solon.framework.service.IBaseService;
import cloud.flystar.solon.quartz.service.entity.JobLog;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.util.Date;

/**
 * 定时任务日志服务
 */
public interface JobLogService extends IBaseService<JobLog> {
    /**
     * 按照任务和时间删除日志（物理删除）
     * @param jobConfigId
     * @param beforeTime
     */
    void removeBeforeTime(@NotNull Long jobConfigId, @Past @NotNull Date beforeTime);
}
