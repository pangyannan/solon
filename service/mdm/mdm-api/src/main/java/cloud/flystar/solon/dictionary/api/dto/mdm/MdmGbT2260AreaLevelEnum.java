package cloud.flystar.solon.dictionary.api.dto.mdm;


/**
 * 省市区界别
 */
public enum MdmGbT2260AreaLevelEnum {
    Province(1, "Province-省"),
    City(2, "City-市"),
    District(3, "District-县区")
    ;


    private final Integer code;
    private final String message;

    private MdmGbT2260AreaLevelEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public Integer getCode() {
        return this.code;
    }

    public String getMessage() {
        return this.message;
    }

    public static MdmGbT2260AreaLevelEnum getByCode(Integer code){
        if(code == null){
            return null;
        }

        for (MdmGbT2260AreaLevelEnum value : MdmGbT2260AreaLevelEnum.values()) {
            if(value.getCode().equals(code)){
                return value;
            }
        }
        return null;
    }
}
