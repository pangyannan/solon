package cloud.flystar.solon.commons.log.audit;

/**
 * 审计日志
 */
public class DefaultAuditLogStoreImpl implements AuditLogStore {
    @Override
    public void save(AuditLog auditLog) {
        log.info(auditLog.toString());
    }
}
