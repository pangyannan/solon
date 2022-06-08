package cloud.flystar.solon.commons.log.audit;

/**
 * 审计日志持久化
 */
public interface AuditLogStore {
    void save(AuditLog auditLog);
}
