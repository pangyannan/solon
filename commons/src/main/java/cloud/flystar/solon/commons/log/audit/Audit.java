package cloud.flystar.solon.commons.log.audit;



import java.lang.annotation.*;

/**
 * 审计日志
 * 如果标记在类上，则所有方法记录日志
 * 如果标记在方法上，则该方法记录日志
 * 如果都标记了，则依据子覆盖父配置
 */
@Target({ElementType.TYPE,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Audit {

    /**
     * 模块名称，默认取类名称
     */
    String moduleName() default "";

    /**
     * 方法名称，默认取方法名称
     */
    String methodName() default "";

    /**
     * 标签
     * @return
     */
    String[] label() default {};


    /**
     * 是否打印方法入参数
     * @return
     */
    boolean paramLog() default true;

    /**
     * 是否打印返回参数
     */
    boolean responseLog() default true;
}
