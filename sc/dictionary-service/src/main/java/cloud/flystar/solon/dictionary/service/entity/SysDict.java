package cloud.flystar.solon.dictionary.service.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 数据字典主表
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
