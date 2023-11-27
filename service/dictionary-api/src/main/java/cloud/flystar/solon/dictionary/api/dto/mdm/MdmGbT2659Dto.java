package cloud.flystar.solon.dictionary.api.dto.mdm;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * 世界各国和地区名称代码（GB/T 2659-2000)
 */
@Data
@Accessors(chain = true)
public class MdmGbT2659Dto {
    /**
     * 两字符代码
     */
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
}
