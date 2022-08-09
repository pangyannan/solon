package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.DepartmentService;
import cloud.flystar.solon.user.service.entity.Department;
import cloud.flystar.solon.user.service.mapper.DepartmentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class DepartmentServiceImpl  extends BaseServiceImpl<DepartmentMapper,Department> implements DepartmentService {
}
