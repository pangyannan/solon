package cloud.flystar.solon.dictionary.api.dto;

import cloud.flystar.solon.commons.bean.constant.YesOrNoEnum;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 数据字典明细
 */
@Data
@Accessors(chain = true)
public class SysDictDetailDto {
    private Long dictDetailId;
    /**
     * 字典ID
     */
    private Long dictId;

    /**
     * 字典键值
     */
    private String dictCode;

    /**
     * 字典标签
     */
    private String dictLabel;

    /**
     * 字典排序
     */
    private Integer dictIndex;

    /**
     * 是否默认
     * 0-否  表示非默认
     * 1-是  表示默认
     * @see YesOrNoEnum
     */
    private Integer defaultFlag;


    /**
     * 启用状态
     * @see YesOrNoEnum
     */
    private Integer enableFlag;


    /**
     * 备注
     */
    private String remark;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
