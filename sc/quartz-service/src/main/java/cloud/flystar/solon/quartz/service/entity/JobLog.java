package cloud.flystar.solon.quartz.service.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 任务执行日志
 */
@Data
@Accessors(chain = true)
@TableName("job_log")
public class JobLog {
    /**
     * 日志ID
     */
    @TableId
    private Long id;
    /**
     * 任务ID
     */
    private Long jobConfigId;
    /**
     * 任务执行参数
     */
    private String param;

    /**
     * 任务开始时间
     */
    private LocalDateTime startTime;
    /**
     * 任务结束时间
     */
    private LocalDateTime endTime;

    /**
     * 执行结果  0-失败，1-成功
     */
    private Integer jobSuccess;

    /**
     * 执行结果信息
     */
    private String message;


    /**
     * 执行任务的IP
     */
    private String instanceIp;
}
