package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.lang.reflect.Method;
import java.util.stream.Collectors;

/**
 * 全局异常处理
 */
@Slf4j
@ResponseBody
@ControllerAdvice
public class ExceptionAdviceConfig {

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
        log.warn("参数校验失败class={},method={},message={}", className, methodName, message);
        return  Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0400.getCode(),message);
    }
}
