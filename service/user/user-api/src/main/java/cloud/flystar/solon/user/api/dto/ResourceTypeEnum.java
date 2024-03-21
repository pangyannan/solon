package cloud.flystar.solon.user.api.dto;

import lombok.Getter;

/**
 * 资源类型
 */
@Getter
public enum ResourceTypeEnum {
    APP("app","前端项目"),
    MENU("menu","菜单"),
    ACTION("action","动作"),
    API("api","接口"),
    DATA_SCOPE("data","数据范围"),
    ;
     private String key;
     private String value;

    ResourceTypeEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }
}
