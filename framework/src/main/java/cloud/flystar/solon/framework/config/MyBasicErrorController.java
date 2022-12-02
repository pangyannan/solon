package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.commons.log.trace.TraceContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.web.servlet.error.AbstractErrorController;
import org.springframework.boot.web.error.ErrorAttributeOptions;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 *一般是处理4xx错误
 * 4xx错误无法被@ControllerAdvice补货，故自定义处理
 */
@RestController
@Slf4j
@RequestMapping("/error")
public class MyBasicErrorController extends AbstractErrorController {
   private ErrorAttributeOptions options = ErrorAttributeOptions.defaults()
           .including(new ErrorAttributeOptions.Include[]{ErrorAttributeOptions.Include.EXCEPTION})
           .including(new ErrorAttributeOptions.Include[]{ErrorAttributeOptions.Include.STACK_TRACE})
           .including(new ErrorAttributeOptions.Include[]{ErrorAttributeOptions.Include.MESSAGE})
           .including(new ErrorAttributeOptions.Include[]{ErrorAttributeOptions.Include.BINDING_ERRORS});

   private String errorAttributesError= "error";
   private String errorAttributesMsg = "message";
   private String errorAttributesPath = "path";


    public MyBasicErrorController(ErrorAttributes errorAttributes) {
        super(errorAttributes);
    }

    @RequestMapping
    public Result error(HttpServletRequest request) {
        HttpStatus status = this.getStatus(request);
        Map<String, Object> body = this.getErrorAttributes(request, options);

        Map<String,Object> map = new HashMap<>(2);
        map.put(errorAttributesPath,body.get(errorAttributesPath));
        map.put(errorAttributesMsg,body.get(errorAttributesMsg));


        Result<Object> result = Result.failedBuild(String.valueOf(status.value()), status.getReasonPhrase())
                .setDetailMessage(map.toString())
                .setTraceId(TraceContext.getTraceId());
        log.error(JsonUtil.json(result));
        return result;

    }

    @ExceptionHandler({HttpMediaTypeNotAcceptableException.class})
    public ResponseEntity<String> mediaTypeNotAcceptable(HttpServletRequest request) {
        HttpStatus status = this.getStatus(request);
        return ResponseEntity.status(status).build();
    }

}
