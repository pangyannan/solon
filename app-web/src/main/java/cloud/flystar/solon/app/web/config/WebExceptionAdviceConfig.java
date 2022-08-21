package cloud.flystar.solon.app.web.config;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import cn.dev33.satoken.exception.NotLoginException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.lang.reflect.Method;
import java.util.stream.Collectors;

/**
 * 全局异常处理
 */
@Slf4j
@ResponseBody
@ControllerAdvice
public class WebExceptionAdviceConfig {

    @ResponseStatus(value= HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(value = NotLoginException.class)
    public Result<String> exceptionHandler(NotLoginException notLoginException){
        return  Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0220);
    }
}
