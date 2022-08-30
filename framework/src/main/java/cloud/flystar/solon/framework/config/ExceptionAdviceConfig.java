package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.bean.excetion.ErrorCodeEnum;
import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.exception.NotPermissionException;
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
public class ExceptionAdviceConfig {
    @ResponseStatus(value= HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(value = Exception.class)
    public Result globeException(Exception e){
        log.error("全局异常拦截",e);
        return  Result.failedBuild(ErrorCodeEnum.SYSTEM_ERROR_B0001).setDetailMessage(e.getMessage());
    }


    @ResponseStatus(value= HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = BindException.class)
    public Result<String> exceptionHandler(BindException e){
        BindingResult bindingResult = e.getBindingResult();
        String message = bindingResult.getFieldErrors()
                .stream()
                .map(fieldError -> fieldError.getDefaultMessage())
                .collect(Collectors.joining("; "));

        //记录日志
        String className = null;
        String methodName = null;
        if(e instanceof MethodArgumentNotValidException){
            MethodParameter parameter = ((MethodArgumentNotValidException) e).getParameter();
            Method method = parameter.getMethod();
            if(method!=null){
                methodName = method.getName();
            }
            if(method != null && method.getDeclaringClass() != null){
                className =  method.getDeclaringClass().getName();

            }
        }
        log.warn("class={},method={},message={}", className, methodName, message,e);
        return  Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0400.getCode(),message);
    }

    @ResponseStatus(value= HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(value = NotLoginException.class)
    public Result<String> exceptionHandler(NotLoginException exception){
        log.error("未登陆",exception);
        return  Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0220);
    }

    @ResponseStatus(value= HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(value = NotPermissionException.class)
    public Result<String> exceptionHandler(NotPermissionException exception){
        log.error("未授权",exception);
        return  Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0301);
    }
}
