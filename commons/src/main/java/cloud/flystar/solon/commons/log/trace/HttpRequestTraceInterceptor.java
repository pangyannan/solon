package cloud.flystar.solon.commons.log.trace;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.RequestFacade;
import org.apache.tomcat.util.http.MimeHeaders;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Field;

/**
 * @Author: pangyannan
 * @Data: 2021/6/10
 * @Description: traceId 日志拦截器
 */
@Slf4j
public class HttpRequestTraceInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //从request中获取traceId，如果没有就自己生成一个，放到Context中，以及返回response
        String traceId = request.getHeader(TraceContext.TRACE_ID_NAME);
        if(StrUtil.isEmpty(traceId)){
            traceId = IdUtil.simpleUUID();
        }



        Integer spanId  = 0;
        String spanIdStr = request.getHeader(TraceContext.SPAN_ID_NAME);
        if(StrUtil.isNotEmpty(spanIdStr)){
            spanId = Integer.valueOf(spanIdStr) + 1;
        }

        addHeader(request,response,traceId,spanId);

        TraceContext.putTraceId(traceId);
        TraceContext.putMdcTraceId(traceId);

        TraceContext.putSpanId(spanId);
        TraceContext.putMdcSpanId(spanId);

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        //访问结束后，清除Context
        TraceContext.removeAll();
    }


    /**
     * @link https://www.jianshu.com/p/6549bef972c0
     */
    @SneakyThrows
    private void addHeader(HttpServletRequest request,HttpServletResponse response, String traceId, Integer spanId){
        if(request instanceof RequestFacade ){
            // 从 RequestFacade 中获取 org.apache.catalina.connector.Request
            Field connectorField = ReflectionUtils.findField(RequestFacade.class, "request", Request.class);
            connectorField.setAccessible(true);
            Request connectorRequest = (Request) connectorField.get(request);

            // 从 org.apache.catalina.connector.Request 中获取 org.apache.coyote.Request
            Field coyoteField = ReflectionUtils.findField(Request.class, "coyoteRequest", org.apache.coyote.Request.class);
            coyoteField.setAccessible(true);
            org.apache.coyote.Request coyoteRequest = (org.apache.coyote.Request) coyoteField.get(connectorRequest);

            // 从 org.apache.coyote.Request 中获取 MimeHeaders
            Field mimeHeadersField =  ReflectionUtils.findField(org.apache.coyote.Request.class, "headers", MimeHeaders.class);
            mimeHeadersField.setAccessible(true);
            MimeHeaders mimeHeaders =  (MimeHeaders) mimeHeadersField.get(coyoteRequest);

            mimeHeaders.removeHeader("Trace-Id");
            mimeHeaders.addValue("Trace-Id").setString(traceId);

            mimeHeaders.removeHeader("Span-Id");
            mimeHeaders.addValue("Span-Id").setString(spanId.toString());
        }

        response.setHeader("Trace-Id",traceId);
    }
}