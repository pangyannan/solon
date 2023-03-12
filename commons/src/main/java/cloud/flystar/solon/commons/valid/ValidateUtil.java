package cloud.flystar.solon.commons.valid;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.bean.excetion.ErrorCodeEnum;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import org.hibernate.validator.HibernateValidator;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 参数校验工具类
 */
public class ValidateUtil {
    /**
     * 非快速失败校验，即校验全部属性
     */
    private static Validator validator = Validation.byProvider(HibernateValidator.class)
            .configure()
            .failFast(false)
            .buildValidatorFactory()
            .getValidator();

    /**
     * 快速失败校验，即校验遇到异常就结束校验
     */
    private static Validator validatorFailFast = Validation.byProvider(HibernateValidator.class)
            .configure()
            .failFast(true)
            .buildValidatorFactory()
            .getValidator();

    /**
     * 获取校验器实例
     */
    public static Validator getValidator() {
        return validator;
    }


    /**
     * 获取校验器实例
     */
    public static Validator getValidatorFailFast() {
        return validatorFailFast;
    }

    /**
     * 校验对象
     */
    public static <T> Set<ConstraintViolation<T>> validateConstraintViolation(T bean, Class<?>... groups) {
        return validator.validate(bean, groups);
    }

    /**
     * 校验对象
     */
    public static <T> Set<ConstraintViolation<T>> validateConstraintViolationFailFast(T bean, Class<?>... groups) {
        return validatorFailFast.validate(bean, groups);
    }

    /**
     * 校验参数,全部校验后再返回
     */
    public static <T> Result validate(T t,Class<?>... group){
        return validate(t,false,group);
    }


    /**
     * 校验参数
     */
    public static <T> Result validate(T t, boolean failFast,Class<?>... group){
        String msg= "";
        Set<ConstraintViolation<T>> cvs;
        if(failFast){
            cvs = validateConstraintViolationFailFast(t,group);
        }else{
            cvs = validateConstraintViolation(t,group);
        }
        if(CollectionUtil.isNotEmpty(cvs)){
            msg = cvs.stream().map(ConstraintViolation::getMessage).collect(Collectors.joining(", "));
        }
        if(StrUtil.isNotBlank(msg)){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0400).setDetailMessage(msg);
        }

        return Result.successBuild();
    }

    /**
     * 校验参数列表，每一行参数校验结果均返回
     */
    public static <T> Result validate(List<T> tList, Class<?>... group){
        StringBuilder stringBuilder = new StringBuilder();
        for(int i=0; i<tList.size(); i++){
            Result result = validate(tList.get(i),group);
            if(!result.getSuccess()){
                stringBuilder.append("第").append(i+1).append("行:").append(result.getDetailMessage()).append(";\n");
            }
        }
        if(stringBuilder.length() > 0){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0400).setDetailMessage(stringBuilder.toString());
        }
        return Result.successBuild();
    }
}
