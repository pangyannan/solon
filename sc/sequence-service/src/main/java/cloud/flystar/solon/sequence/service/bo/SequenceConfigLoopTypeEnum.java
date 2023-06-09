package cloud.flystar.solon.sequence.service.bo;

import cn.hutool.core.util.StrUtil;

public enum SequenceConfigLoopTypeEnum {
    NONE("NONE","无循环"),
    DATE("DATE","时间")
    ;
    private String code;
    private String name;

    SequenceConfigLoopTypeEnum(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    public static SequenceConfigLoopTypeEnum getByCode(String code){
        for (SequenceConfigLoopTypeEnum value : SequenceConfigLoopTypeEnum.values()) {
            if(value.getCode().equals(code)){
                return value;
            }
        }
        throw new IllegalArgumentException(String.format("code=[%s] is not found SequenceConfigLoopTypeEnum"));
    }

}
