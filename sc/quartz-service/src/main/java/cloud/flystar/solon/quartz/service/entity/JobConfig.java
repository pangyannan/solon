package cloud.flystar.solon.quartz.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * TODO
 *
 * @author: pangyannan
 */
@Data
@TableName("job_config")
public class JobConfig implements Serializable {
    private static final Long serialVersionUID = 1L;
    /** 任务id */
    @TableId
    private Long id;

    /** 任务名称 */
    private String jobName;

    /** 任务组 */
    private String jobGroup;

    /** 任务执行className*/
    private String className;


    /** 任务状态 0-暂停  1-启动*/
    private Integer status;

    /**
     * 任务开始时间
     */
    private Date startTime;

    /**
     * 任务结束时间
     */
    private Date endTime;

    /** 任务运行时间表达式 */
    private String cron;

    /**
     * 任务参数，一般是JSON-MAP格式
     */
    private String param;

    /**
     * 日志保留最大天数
     */
    private Integer maxLogDay;

    /**
     * 删除标记
     */
    @TableLogic(value = "0" , delval = "1")
    private Integer deleteFlag;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;

}
