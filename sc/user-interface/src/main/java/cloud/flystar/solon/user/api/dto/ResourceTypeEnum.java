package cloud.flystar.solon.user.api.dto;

import lombok.Getter;

/**
 * 资源类型
 */
@Getter
public enum ResourceTypeEnum {
    APP("app","前端项目"),
    MENU("menu","惨的"),
    ELEMENT("element","页面元素"),
    API("api","页面元素"),
    ;
     private String key;
     private String value;

    ResourceTypeEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }
}
