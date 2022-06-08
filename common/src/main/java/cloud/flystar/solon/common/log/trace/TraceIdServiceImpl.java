package cloud.flystar.solon.common.log.trace;

import cloud.flystar.solon.common.base.TraceService;

public class TraceIdServiceImpl implements TraceService {
    @Override
    public Integer order() {
        return 0;
    }

    @Override
    public String getTraceId() {
        return TraceContext.getTraceId();
    }
}
