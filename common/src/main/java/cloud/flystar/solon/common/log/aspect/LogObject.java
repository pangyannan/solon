package cloud.flystar.solon.common.log.aspect;


import lombok.Data;
import lombok.experimental.Accessors;

/**
 * @Author: pangyannan
 * @Data: 2021/6/5
 * @Description: 审计日志
 */
@Data
@Accessors(chain = true) //链式set
public class LogObject {
    /**
     * 接口请求入参
     */
    private Object param;
    /**
     * 接口返回值
     */
    private Object result;

    /**
     * 接口响应时间,单位毫秒
     */
    private Long costTime;

    /**
     * 方法名称
     */
    private String methodName;

    /**
     * 模块名称
     */
    private String moduleName;

    public String preLog() {
        return "preLog{" +
                "moduleName='" + moduleName + '\'' +
                ", methodName='" + methodName + '\'' +
                ", param=" + param +
                '}';
    }

    public String postLog(){
        return "postLog{" +
                "moduleName='" + moduleName + '\'' +
                ", methodName='" + methodName + '\'' +
                ", param=" + param +
                ", result=" + result +
                ", costTime=" + costTime +
                '}';
    }


}
