package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.log.trace.TraceUtil;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * 响应返回结果增强器
 */
@RestControllerAdvice
public class ResultAdvice implements ResponseBodyAdvice<Object> {

    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return true;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        if(body !=null && body instanceof Result){
            Result result = (Result) body;
            String traceId = result.getTraceId();
            if(traceId == null){
                traceId = TraceUtil.getTraceId();
                result.setTraceId(traceId);
            }

        }
        return body;
    }
}
