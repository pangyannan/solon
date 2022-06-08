package cloud.flystar.solon.commons.log.audit;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AuditLogStoreImpl implements AuditLogStore {
    @Override
    public void save(AuditLog auditLog) {
        log.info(auditLog.toString());
    }
}
