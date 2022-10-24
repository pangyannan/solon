package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import cloud.flystar.solon.dictionary.api.SysConfigApi;
import cloud.flystar.solon.dictionary.api.dto.SysConfigDto;
import cloud.flystar.solon.dictionary.service.convert.SysConfigDtoConvert;
import cloud.flystar.solon.dictionary.service.entity.SysConfig;
import cloud.flystar.solon.dictionary.service.inner.SysConfigService;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class SysConfigApiImpl implements SysConfigApi {
    @Resource
    private SysConfigService sysConfigService;

    @Resource
    private SysConfigDtoConvert sysConfigDtoConvert;

    @Override
    public SysConfigDto getById(Long sysConfigId) {
        if(sysConfigId == null){
            return null;
        }
        SysConfig sysConfig = sysConfigService.getById(sysConfigId);
        return sysConfigDtoConvert.doForward(sysConfig);
    }

    @Override
    public List<SysConfigDto> listByIds(List<Long> sysConfigIds) {
        if(CollectionUtil.isEmpty(sysConfigIds)){
            return ListUtil.empty();
        }
        List<SysConfig> sysConfigs = sysConfigService.listByIds(sysConfigIds);
        return sysConfigDtoConvert.doForward(sysConfigs);
    }

    @Override
    public SysConfigDto getByConfigKey(String configKey) {
        if(StrUtil.isBlank(configKey)){
            return null;
        }
        SysConfig sysConfig = sysConfigService.lambdaQuery().eq(SysConfig::getConfigKey, configKey).one();
        return sysConfigDtoConvert.doForward(sysConfig);
    }

    @Override
    public List<SysConfigDto> listByConfigKeys(List<String> configKeys) {
        if(CollectionUtil.isEmpty(configKeys)){
            return ListUtil.empty();
        }
        List<SysConfig> sysConfigs = sysConfigService.lambdaQuery().in(SysConfig::getConfigKey, configKeys).list();
        return sysConfigDtoConvert.doForward(sysConfigs);
    }

    @Override
    public SysConfigDto getByConfigKeyAndEnable(String configKey) {
        SysConfigDto sysConfigDto = this.getByConfigKey(configKey);
        if(sysConfigDto != null & YesOrNo.isYes(sysConfigDto.getEnableFlag())){
            return sysConfigDto;
        }
        return null;
    }

    @Override
    public List<SysConfigDto> listByConfigKeysAndEnable(List<String> configKeys) {
        List<SysConfigDto> sysConfigDtoList = this.listByConfigKeys(configKeys);
        return sysConfigDtoList.stream().filter(t->YesOrNo.isYes(t.getEnableFlag())).collect(Collectors.toList());
    }
}
