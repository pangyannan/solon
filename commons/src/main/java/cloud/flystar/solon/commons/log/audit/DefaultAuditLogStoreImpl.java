package cloud.flystar.solon.commons.log.audit;

import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.commons.log.trace.TraceContext;
import cn.hutool.core.util.StrUtil;

/**
 * 审计日志
 */
public class DefaultAuditLogStoreImpl implements AuditLogStore {
    @Override
    public void save(AuditLog auditLog) {
        if(auditLog == null){
            return;
        }
        Object resultObject = auditLog.getResult();
        if(resultObject !=null && resultObject instanceof Result){
            Result result = (Result) resultObject;
            String traceId = result.getTraceId();
            if(StrUtil.isBlank(traceId)){
                traceId = TraceContext.getTraceId();
                result.setTraceId(traceId);
            }
        }
        log.info("auditLog:{}",JsonUtil.json(auditLog));
    }
}
