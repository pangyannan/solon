package cloud.flystar.solon.dictionary.service.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 世界各国和地区名称代码（GB/T 2659-2000)
 */
@Data
@TableName("mdm_gbt2259")
public class  MdmGbT2659 {
    /**
     * 两字符代码
     */
    @TableId(type = IdType.INPUT)
    private String countryCode2;
     /**
     * 三字符代码
     */
     private String countryCode3;
     /**
     * 数字代码
     */
     private String countryNumber;

    /**
     * 英文简称
     */
    private String countryShortNameEn;

    /**
     * 英文全称
     */
    private String countryNameEn;
    /**
     * 中文简称
     */
    private String countryShortNameCn;

    /**
     * 备注
     */
    private String remark;

    private LocalDateTime createTime;
    private LocalDateTime updateTime;

}
