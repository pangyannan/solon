package cloud.flystar.solon.user.service.impl;

import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cloud.flystar.solon.user.service.DepartmentService;
import cloud.flystar.solon.user.service.entity.Department;
import cloud.flystar.solon.user.service.entity.Role;
import cloud.flystar.solon.user.service.entity.UserDepartmentRef;
import cloud.flystar.solon.user.service.entity.UserRoleRef;
import cloud.flystar.solon.user.service.mapper.DepartmentMapper;
import cloud.flystar.solon.user.service.mapper.UserDepartmentRefMapper;
import cloud.flystar.solon.user.service.mapper.UserRoleRefMapper;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeBuilder;
import cn.hutool.core.lang.tree.TreeNodeConfig;
import com.baomidou.mybatisplus.extension.toolkit.ChainWrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
public class DepartmentServiceImpl  extends BaseServiceImpl<DepartmentMapper,Department> implements DepartmentService {
    @Resource
    UserDepartmentRefMapper userDepartmentRefMapper;

    @Override
    public List<Department> listUserDepartment(@NotNull Long userId) {
        List<UserDepartmentRef> userDepartmentRefs = ChainWrappers.lambdaQueryChain(userDepartmentRefMapper)
                .eq(UserDepartmentRef::getUserId, userId)
                .list();
        if(CollectionUtil.isEmpty(userDepartmentRefs)){
            return ListUtil.empty();
        }

        Set<Long> deptIds = userDepartmentRefs.stream().map(UserDepartmentRef::getDeptId).collect(Collectors.toSet());
        return this.lambdaQuery()
                .in(Department::getDeptId, deptIds)
                .eq(Department::getStatus, YesOrNo.YES.getKey())
                .list();
    }

    @Override
    public List<Department> listByParentId(@NotNull Long deptId) {
        List<Department> list = this.list();

        //todo
        return list;
    }
}
