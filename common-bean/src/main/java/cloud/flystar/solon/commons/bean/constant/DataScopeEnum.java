package cloud.flystar.solon.commons.bean.constant;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import lombok.Getter;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 数据范围类型
 */
public enum DataScopeEnum {
    ALL("all","所有数据权限"),
    DEPT_CHILD("deptChild","本部门及子部门数据权限"),
    DEPT_CURRENT("deptCurrent","本部门数据权限"),
    CREATOR("creator","本人数据权限"),
    ;
     private String code;
     private String value;

    private DataScopeEnum(String code, String value) {
        this.code = code;
        this.value = value;
    }

    public String getCode() {
        return this.code;
    }

    public String getValue() {
        return this.value;
    }

    public static DataScopeEnum getByCode(String code){
        if(code == null){
            return null;
        }

        for (DataScopeEnum e : DataScopeEnum.values()) {
            if(e.getCode().equals(code)){
                return e;
            }
        }
        return null;
    }

    public static List<DataScopeEnum> getByCodes(List<String> codes){
        if(CollectionUtil.isEmpty(codes)){
            return ListUtil.empty();
        }

        return codes.stream().map(t -> DataScopeEnum.getByCode(t)).filter(Objects::nonNull).collect(Collectors.toList());
    }
}
