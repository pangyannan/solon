package cloud.flystar.solon.common.log.trace;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author: pangyannan
 * @Data: 2021/6/10
 * @Description: traceId 日志拦截器
 */
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
}
