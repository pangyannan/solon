package cloud.flystar.solon.common.log.audit;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

/**
 * 操作审计日志
 */
@Data
@Accessors(chain = true)
public class AuditLog {

    /**
     * 请求时间
     */
    @JsonProperty(index = 0)
    private LocalDateTime time;

    /**
     * 标签
     * 新增、修改、删除、导出、导入、登陆、登出...
     */
    @JsonProperty(index = 1)
    private String label;

    /**
     * 模块名称
     */
    @JsonProperty(index = 2)
    private String module;

    /**
     * 方法名称
     */
    @JsonProperty(index = 3)
    private String method;
    /**
     * 请求路径
     */
    @JsonProperty(index = 4)
    private String path;

    /**
     * 请求参数
     */
    @JsonProperty(index = 5)
    private Object param;

    /**
     * 返回值
     */
    @JsonProperty(index = 6)
    private Object result;

    /**
     * 接口响应时间,单位毫秒
     */
    @JsonProperty(index = 7)
    private Long costTime;

    /**
     * 是否成功
     */
    @JsonProperty(index = 8)
    private Boolean success;

    /**
     * 错误信息
     */
    @JsonProperty(index = 9)
    private String errorMsg;

    /**
     * 请求IP
     */
    @JsonProperty(index = 101)
    private String ip;

    /**
     * 请求地点
     */
    @JsonProperty(index = 102)
    private String location;

    /**
     * 操作人员ID
     */
    @JsonProperty(index = 103)
    private String uid;

    /**
     * 操作人员姓名
     */
    @JsonProperty(index = 104)
    private String uname;
}
