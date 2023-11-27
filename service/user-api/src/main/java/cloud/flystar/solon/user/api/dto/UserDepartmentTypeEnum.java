package cloud.flystar.solon.user.api.dto;

import lombok.Getter;

/**
 * 员工部门关系类型
 */
@Getter
public enum UserDepartmentTypeEnum {
    employee("employee","普通员工"),
    leader("leader","部门负责人"),
    ;

    private String key;
    private String value;

    UserDepartmentTypeEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }


    public static UserDepartmentTypeEnum getByKey(String key){
        if(key == null){
            return null;
        }
        for (UserDepartmentTypeEnum e : UserDepartmentTypeEnum.values()) {
            if(e.getKey().equals(key)){
                return e;
            }
        }
        return null;
    }
}
