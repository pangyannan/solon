package cloud.flystar.solon.commons.httpclient;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * TODO
 *
 * @author: pangyannan
 */
@AllArgsConstructor
@Getter
public enum HttpContentTypeEnum {
    /**
     * json请求
     */
    JSON("application/json; charset=UTF-8"),

    /**
     * urlencoded请求
     */
    URL_ENCODING("application/x-www-form-urlencoded; charset=UTF-8");

    private final String contentType;

}
