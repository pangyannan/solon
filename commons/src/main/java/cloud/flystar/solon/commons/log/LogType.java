package cloud.flystar.solon.commons.log;

/**
 * @Author: pangyannan
 * @Data: 2021/6/11
 * @Description: 日志打印的方式
 */
public enum LogType {
    /**
     * 只在方法执行前打印
     */
    PRE,
    /**
     * 只在方法后打印
     */
    POST,

    /**
     * 在方法执行前和方法执行后均打印
     */
    PRE_AND_POST;
}
