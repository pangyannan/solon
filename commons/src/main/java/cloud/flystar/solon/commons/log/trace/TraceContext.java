package cloud.flystar.solon.commons.log.trace;

import cloud.flystar.solon.commons.pool.ThreadContext;
import cloud.flystar.solon.commons.pool.ThreadContextConstants;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.ttl.TransmittableThreadLocal;
import org.slf4j.MDC;

import java.util.Objects;
import java.util.Optional;

/**
 * @Author: pangyannan
 * @Data: 2021/6/10
 * @Description: 日志线程上下文环境
 */
public class TraceContext {


    public static void initTrace(String traceId,Integer spanId){
        ThreadContext.put(ThreadContextConstants.TRACE_ID.getCode(),traceId);
        ThreadContext.put(ThreadContextConstants.TRACE_SPAN_ID.getCode(),spanId);

        MDC.put(ThreadContextConstants.TRACE_ID.getCode(),traceId);
        MDC.put(ThreadContextConstants.TRACE_SPAN_ID.getCode(),spanId.toString());
    }


    public static String getTraceIdKey() {
        return ThreadContextConstants.TRACE_ID.getCode();
    }

    public static String getSpanIdKey() {
        return ThreadContextConstants.TRACE_SPAN_ID.getCode();
    }

    public static String getTraceId() {
        return Optional.ofNullable(ThreadContext.get(ThreadContextConstants.TRACE_ID.getCode()))
                .map(Objects::toString).orElse(null);
    }

    public static Integer getSpanId() {
        return Optional.ofNullable(ThreadContext.get(ThreadContextConstants.TRACE_SPAN_ID.getCode()))
                .map(Objects::toString)
                .map(Integer::valueOf).orElse(null);
    }


    public static void clearContext(){
        ThreadContext.remove(ThreadContextConstants.TRACE_ID.getCode());
        ThreadContext.remove(ThreadContextConstants.TRACE_SPAN_ID.getCode());
        MDC.remove(ThreadContextConstants.TRACE_ID.getCode());
        MDC.remove(ThreadContextConstants.TRACE_SPAN_ID.getCode());
    }
}
