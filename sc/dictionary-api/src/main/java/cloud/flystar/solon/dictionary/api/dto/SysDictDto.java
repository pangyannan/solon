package cloud.flystar.solon.dictionary.api.dto;


import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 数据字典主表
 */
@Data
@Accessors(chain = true)
public class SysDictDto {

    private Long dictId;

    /**
     * 字典类型编码
     * 只能包含大小写英文、英文下划线
     * 全局唯一
     */
    private String dictType;

    /**
     * 字典名称
     */
    private String dictName;
    /**
     * 属性命名建议
     */
    private String dictFieldOpinions;
    /**
     * 启用状态
     * @see YesOrNo
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


    /**
     * 字典值集合
     */
    private List<SysDictDetailDto> detailList;
}
