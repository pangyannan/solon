package cloud.flystar.solon.dictionary.service.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 数据字典明细
 */
@Data
@TableName("sys_dict_detail")
public class SysDictDetail {
    @TableId
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
     * 是否默认
     * 0-非默认
     * 1-默认
     */
    private Integer defaultFlag;


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
