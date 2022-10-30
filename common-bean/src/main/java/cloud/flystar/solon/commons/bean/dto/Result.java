package cloud.flystar.solon.commons.bean.dto;

import cloud.flystar.solon.commons.bean.excetion.ErrorCodeEnum;
import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

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
    private Boolean success;
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
    private String time;
    /**
     * 返回数据
     */
    private T data;

    private Result() {
    }

    public Result(Boolean success, String code, String message, T data) {
        this.success = success;
        this.code = code;
        this.message = message;
        this.data = data;
        this.time = OffsetDateTime.now().toString();
    }

    public static <T> Result<T> successBuild(){
        return new Result<>(Boolean.TRUE, ErrorCodeEnum.SUCCESS.getCode(), ErrorCodeEnum.SUCCESS.getMessage(), null);
    }
    public static <T> Result<T> successBuild(T data){
        return new Result<>(Boolean.TRUE, ErrorCodeEnum.SUCCESS.getCode(), ErrorCodeEnum.SUCCESS.getMessage(), data);
    }

    public static <T> Result<T> failedBuild(){
        return new Result<>(Boolean.FALSE, ErrorCodeEnum.SYSTEM_ERROR_B0001.getCode(), ErrorCodeEnum.SYSTEM_ERROR_B0001.getMessage(), null);
    }

    public static <T> Result<T> failedBuild(String code,String message){
        return new Result<>(Boolean.FALSE, code, message, null);
    }
    public static <T> Result<T> failedBuild(ErrorCodeEnum errorCodeEnum){
        return new Result<>(Boolean.FALSE, errorCodeEnum.getCode(), errorCodeEnum.getMessage(), null);
    }
}
