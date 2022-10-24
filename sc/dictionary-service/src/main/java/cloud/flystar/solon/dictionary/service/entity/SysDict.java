package cloud.flystar.solon.dictionary.service.entity;

import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 数据字典主表
 * 一般意义上的字典，有以下特征
 * 1.字典明细是有限集合，一般集合数量不大，在10个以内
 * 2.字典明细是单纯的分类，使用时只依赖 dictCode做逻辑处理，以及dictLabel做展示用
 * 如果以上不能满足，则建议单独建立主数据表，比如省市区就不适合用字典
 */
@Data
@TableName("sys_dict")
public class SysDict {
    @TableId
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



    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;

}
