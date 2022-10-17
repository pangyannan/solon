package cloud.flystar.solon.dictionary.api.dto;

import cloud.flystar.solon.commons.bean.constant.YesOrNoEnum;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 系统配置
 */
@Data
@Accessors(chain = true)
public class SysConfigDto {

    /** 参数主键 */
    private Long sysConfigId;

    /** 参数键名 */
    private String configKey;

    /** 参数名称 */
    private String configName;

    /** 参数键值 */
    private String configValue;

    /** 系统内置
     *  0-否  非系统内置
     *  1-是  系统内置
     *  @see YesOrNoEnum
     */
    private Integer configType;

    /**
     * 启用状态
     * @see YesOrNoEnum
     */
    private Integer enableFlag;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;


}
