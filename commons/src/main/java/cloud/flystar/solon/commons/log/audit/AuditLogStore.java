package cloud.flystar.solon.commons.log.audit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 审计日志持久化
 */
public interface AuditLogStore {
    Logger log = LoggerFactory.getLogger("AuditLogStore");
    void save(AuditLog auditLog);
}
