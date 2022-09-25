package cloud.flystar.solon.dictionary.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 系统参数配置表
 */
@Data
@TableName("sys_config")
public class SysConfig {

    /** 参数主键 */
    @TableId(type = IdType.ASSIGN_ID)
    private Long sysConfigId;

    /** 参数键名 */
    private String configKey;

    /** 参数名称 */
    private String configName;

    /** 参数键值 */
    private String configValue;

    /** 系统内置（Y是 N否） */
    private String configType;


    @TableLogic
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
