package cloud.flystar.solon.commons.dto;

import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import cloud.flystar.solon.commons.log.trace.TraceUtil;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 统一返回包装
 */
@Data
@Accessors(chain = true)
public class Result<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 成功/失败
     */
    private boolean success;
    /**
     * 错误码
     * @see ErrorCodeEnum
     */
    private String code;
    /**
     * 消息内容
     */
    private String message;

    /**
     * 详细消息内容
     */
    private String detailMessage;

    /**
     * 追踪号
     */
    private String traceId;

    /**
     * 消息时间
     */
    private LocalDateTime time;
    /**
     * 返回数据
     */
    private T data;

    public Result() {
    }

    public Result(boolean success, String code, String message, String traceId, T data) {
        this.success = success;
        this.code = code;
        this.message = message;
        this.traceId = traceId;
        this.data = data;
        this.time = LocalDateTime.now();
    }

    public static <T> Result<T> successBuild(){
        return new Result<>(true,
                ErrorCodeEnum.SUCCESS.getCode(),
                ErrorCodeEnum.SUCCESS.getMessage(),
                TraceUtil.getTraceId(),
                null);
    }
    public static <T> Result<T> successBuild(T data){
        return new Result<>(true,
                ErrorCodeEnum.SUCCESS.getCode(),
                ErrorCodeEnum.SUCCESS.getMessage(),
                TraceUtil.getTraceId(),
                data);
    }

    public static <T> Result<T> failedBuild(){
        return new Result<>(false,
                ErrorCodeEnum.SYSTEM_ERROR_B0001.getCode(),
                ErrorCodeEnum.SYSTEM_ERROR_B0001.getMessage(),
                TraceUtil.getTraceId(),
                null);
    }

    public static <T> Result<T> failedBuild(String code,String message){
        return new Result<>(false,
                code,
                message,
                TraceUtil.getTraceId(),
                null);
    }
    public static <T> Result<T> failedBuild(ErrorCodeEnum errorCodeEnum){
        return new Result<>(false,
                errorCodeEnum.getCode(),
                errorCodeEnum.getMessage(),
                TraceUtil.getTraceId(),
                null);
    }
}
