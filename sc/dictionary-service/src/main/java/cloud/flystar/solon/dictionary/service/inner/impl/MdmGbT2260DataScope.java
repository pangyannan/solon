package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.framework.service.impl.AbstractUserDataScopeService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.function.Consumer;


@Slf4j
@Service
public class MdmGbT2260DataScope extends AbstractUserDataScopeService<MdmGbT2260> {
    @Override
    public String dataScopeKey() {
        return "/data/mdm/gbt2260";
    }

    @Override
    protected Consumer<LambdaQueryWrapper<MdmGbT2260>> assertFilterFalse(Long userId) {
        return queryChainWrapper -> queryChainWrapper.eq(MdmGbT2260::getAreaCode,"");
    }

    @Override
    protected Optional<Consumer<LambdaQueryWrapper<MdmGbT2260>>> all(Long userId) {
        return super.all(userId);
    }

    @Override
    protected SFunction<MdmGbT2260, ?> getDataOwnerDept() {
        return MdmGbT2260::getAreaCode;
    }

    @Override
    protected SFunction<MdmGbT2260, ?> getDataOwnerUser() {
        return MdmGbT2260::getParentCode;
    }
}
