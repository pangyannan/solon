package cloud.flystar.solon.dictionary.service.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * GBT2260-2007
 * 《GBT2260-2007中华人民共和国行政区划代码》
 */
@Data
@TableName("mdm_gbt2260")
public class MdmGbT2260 {
    /**
     * 行政区国标编码
     */
    private String areaCode;
    /**
     * 行政区国标名称
     */
    private String areaName;
    /**
     * 行政区国标编码-父级
     */
    private String parentCode;
    /**
     * 地区级别
     * 1:省/直辖市/自治区/行政区
     * 2:市
     * 3:县/区
     */
    private Integer areaLevel;

    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
