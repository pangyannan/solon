package cloud.flystar.solon.commons.log.trace;

import com.alibaba.ttl.TransmittableThreadLocal;
import org.slf4j.MDC;

/**
 * @Author: pangyannan
 * @Data: 2021/6/10
 * @Description: 日志线程上下文环境
 */
public class TraceContext {
    public static final String TRACE_ID_NAME = "traceId";
    public static final String SPAN_ID_NAME="spanId";

    private static final TransmittableThreadLocal<String> traceIdThreadLocal = new TransmittableThreadLocal<>();
    private static final TransmittableThreadLocal<Integer> spanIdThreadLocal = new TransmittableThreadLocal<>();


    public static void putTraceId(String traceId) {
        traceIdThreadLocal.set(traceId);
    }

    public static String getTraceId() {
        return traceIdThreadLocal.get();
    }

    public static void removeTraceId() {
        traceIdThreadLocal.remove();
    }

    public static void putMdcTraceId(String traceId) {
        MDC.put(TRACE_ID_NAME, traceId);
    }

    public static void removeMdcTraceId() {
        MDC.remove(TRACE_ID_NAME);
    }




    public static void putSpanId(Integer spanId) {
        spanIdThreadLocal.set(spanId);
    }

    public static Integer getSpanId() {
        return spanIdThreadLocal.get();
    }

    public static void removeSpanId() {
        spanIdThreadLocal.remove();
    }

    public static void putMdcSpanId(Integer spanId) {
        MDC.put(SPAN_ID_NAME, String.valueOf(spanId));
    }

    public static void removeMdcSpanId() {
        MDC.remove(SPAN_ID_NAME);
    }

    public static void removeAll(){
        removeTraceId();
        removeMdcTraceId();
        removeSpanId();
        removeMdcSpanId();
    }
}
