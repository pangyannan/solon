package cloud.flystar.solon.commons.util;

import lombok.Data;

/**
 * TODO
 *
 * @author: pangyannan
 */
@Data
public class GeoAddress{
        private String province;
        /**
         * 城市 二级行政区 例如：深圳、成都、凉山州
         */
        private String city;
        /**
         * 区/县 三级行政
         */
        private String county;
        /**
         * 街道
         */
        private String street;
        /**
         * 镇
         */
        private String town;
        /**
         * 村
         */
        private String village;
        /**
         * 其他
         */
        private String other;
}
