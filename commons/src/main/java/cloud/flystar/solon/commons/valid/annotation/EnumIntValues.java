package cloud.flystar.solon.commons.valid.annotation;


import cloud.flystar.solon.commons.valid.validator.EnumIntValuesConstraintValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import javax.validation.constraints.NotNull;
import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = { EnumIntValuesConstraintValidator.class})
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER, ElementType.TYPE_USE})
@Retention(RetentionPolicy.RUNTIME)
@NotNull(message = "不能为空")
public @interface EnumIntValues {
    /**
     * 提示消息
     */
    String message() default "传入的值不在范围内";
    /**
     * 分组
     * @return
     */
    Class<?>[] groups() default { };
    Class<? extends Payload>[] payload() default { };
    /**
     * 可以传入的值
     * @return
     */
    int[] values() ;
}
