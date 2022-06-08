package cloud.flystar.solon.common.valid.validator;

import cloud.flystar.solon.common.valid.annotation.EnumIntValues;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.HashSet;
import java.util.Set;

/**
 * @Author: pangyannan
 * @Data: 2021/6/16
 * @Description: 校验器
 */
public class EnumIntValuesConstraintValidator implements ConstraintValidator<EnumIntValues,Integer> {
    /**
     * 存储枚举的值
     */
    private Set<Integer> set=new HashSet<>();
    /**
     * 初始化方法
     * @param enumIntValues 校验的注解
     */
    @Override
    public void initialize(EnumIntValues enumIntValues) {
        for (int value : enumIntValues.values()) {
            set.add(value);
        }
    }

    @Override
    public boolean isValid(Integer value, ConstraintValidatorContext context) {
        return set.contains(value);
    }
}
