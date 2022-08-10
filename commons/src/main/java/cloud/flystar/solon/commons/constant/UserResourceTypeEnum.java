package cloud.flystar.solon.commons.constant;

import lombok.Getter;

/**
 * 用户资源类型
 */
@Getter
public enum UserResourceTypeEnum {
    APPLICATION("application","用户应用"),
    MENU("menu","菜单"),
    ELEMENT("element","页面元素"),
    API("api","接口资源"),
    ;
    private String key;
    private String value;

    UserResourceTypeEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }
}
