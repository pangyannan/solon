package cloud.flystar.solon.commons.log.trace;


import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;

public class TraceUtil {
    public static String getTraceId(){
        return TraceContext.getTraceId();
    }

    public static void initTrace(){
        String traceId = TraceContext.getTraceId();
        Integer spanId = TraceContext.getSpanId();

        if(StrUtil.isBlank(traceId)){
            traceId = IdUtil.simpleUUID();
        }
        if(spanId == null){
            spanId = 0;
        }else {
            spanId ++;
        }
        TraceContext.putTraceId(traceId);
        TraceContext.putMdcTraceId(traceId);

        TraceContext.putSpanId(spanId);
        TraceContext.putMdcSpanId(spanId);
    }
}
