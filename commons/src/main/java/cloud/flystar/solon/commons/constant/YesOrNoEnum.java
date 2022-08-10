package cloud.flystar.solon.commons.constant;

import lombok.Getter;

@Getter
public enum YesOrNoEnum {
    NO(0,"否"),
    YES(1,"是")
    ;
    private Integer key;
    private String value;

    YesOrNoEnum(Integer key, String value) {
        this.key = key;
        this.value = value;
    }
}
