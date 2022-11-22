package cloud.flystar.solon.user.api.dto;

import lombok.Getter;

/**
 * 数据范围类型
 */
@Getter
public enum DataScopeEnum {
    ALL("ALL","所有数据权限"),
    DEPT_CHILD("DEPT_CHILD","本部门及子部门数据权限"),
    DEPT_CURRENT("DEPT_CURRENT","本部门数据权限"),
    CREATOR("CREATOR","本人数据权限"),
    ;
     private String key;
     private String value;

    DataScopeEnum(String key, String value) {
        this.key = key;
        this.value = value;
    }
}
