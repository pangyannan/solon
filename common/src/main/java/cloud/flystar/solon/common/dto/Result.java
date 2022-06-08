package cloud.flystar.solon.common.dto;

import cloud.flystar.solon.common.base.ErrorCodeEnum;
import cloud.flystar.solon.common.base.TraceServiceSelector;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @Author: pangyannan
 * @Data: 2021/6/14
 * @Description: 统一返回包装
 */
@Data
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
     * 消息提醒
     */
    private String message;
    /**
     * 追踪号
     */
    private String traceId;

    /**
     * 消息时间
     */
    private Date dateTime;
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
        this.dateTime = new Date();
    }

    public static <T> Result<T> successBuild(){
        return new Result<T>(true,
                ErrorCodeEnum.SUCCESS.getCode(),
                ErrorCodeEnum.SUCCESS.getMessage(),
                TraceServiceSelector.getTraceId(),
                null);
    }
    public static <T> Result<T> successBuild(T data){
        return new Result<T>(true,
                ErrorCodeEnum.SUCCESS.getCode(),
                ErrorCodeEnum.SUCCESS.getMessage(),
                TraceServiceSelector.getTraceId(),
                data);
    }

    public static <T> Result<T> failedBuild(){
        return new Result<>(false,
                ErrorCodeEnum.SYSTEM_ERROR_B0001.getCode(),
                ErrorCodeEnum.SYSTEM_ERROR_B0001.getMessage(),
                TraceServiceSelector.getTraceId(),
                null);
    }

    public static <T> Result<T> failedBuild(String code,String message){
        return new Result<T>(false,
                code,
                message,
                TraceServiceSelector.getTraceId(),
                null);
    }
    public static <T> Result<T> failedBuild(ErrorCodeEnum errorCodeEnum){
        return new Result<T>(false,
                errorCodeEnum.getCode(),
                errorCodeEnum.getMessage(),
                TraceServiceSelector.getTraceId(),
                null);
    }
}
