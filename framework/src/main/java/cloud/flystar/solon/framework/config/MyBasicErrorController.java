package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.bean.dto.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.web.servlet.error.AbstractErrorController;
import org.springframework.boot.web.servlet.error.ErrorAttributes;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpMediaTypeNotAcceptableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 *一般是处理4xx错误
 * 4xx错误无法被@ControllerAdvice补货，故自定义处理
 */
@RestController
@Slf4j
@RequestMapping("/error")
public class MyBasicErrorController extends AbstractErrorController {
    public MyBasicErrorController(ErrorAttributes errorAttributes) {
        super(errorAttributes);
    }

    @RequestMapping
    public Result error(HttpServletRequest request) {
        HttpStatus status = this.getStatus(request);
        if (status == HttpStatus.NO_CONTENT) {
            return Result.failedBuild(status.value()+"",status.getReasonPhrase());
        } else {
            return Result.failedBuild(status.value()+"", status.getReasonPhrase());
        }
    }

    @ExceptionHandler({HttpMediaTypeNotAcceptableException.class})
    public ResponseEntity<String> mediaTypeNotAcceptable(HttpServletRequest request) {
        HttpStatus status = this.getStatus(request);
        return ResponseEntity.status(status).build();
    }
}
