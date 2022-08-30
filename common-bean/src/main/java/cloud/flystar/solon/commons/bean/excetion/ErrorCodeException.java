package cloud.flystar.solon.commons.bean.excetion;

import lombok.Getter;

/**
 * 包含异常枚举的异常类
 */
@Getter
public class ErrorCodeException extends Exception{
    private ErrorCodeEnum errorCodeEnum;

    private ErrorCodeException(ErrorCodeEnum errorCodeEnum) {
        super();
        this.errorCodeEnum = errorCodeEnum;
    }

    public static ErrorCodeException build(ErrorCodeEnum errorCodeEnum){
        return new ErrorCodeException(errorCodeEnum);
    }
}
