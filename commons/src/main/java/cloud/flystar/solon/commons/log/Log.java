package cloud.flystar.solon.commons.log;


import java.lang.annotation.*;

/**
 * Web日志记录注解，主要是在controller层
 * 如果标记在类上，则所有方法记录日志
 * 如果标记在方法上，则该方法记录日志
 * 如果都标记了，则依据子覆盖父配置
 */
@Target({ElementType.TYPE,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {

    /**
     * 模块名称，默认取类名称
     */
    String moduleName() default "";

    /**
     * 方法名称，默认取方法名称
     */
    String methodName() default "";

    /**
     * 是否方法开始前就打印入参数,一般关闭即可，使用后置参数打印
     * 如果开启，一般会形成2遍日志，即方法开始的日志和方法结束的日志
     * 一般，preLog 和 responseLog 开启其中的一个就行了
     * @return
     */
    LogType preLog() default LogType.PRE;

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
