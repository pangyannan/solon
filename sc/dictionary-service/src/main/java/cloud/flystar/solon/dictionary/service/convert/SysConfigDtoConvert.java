package cloud.flystar.solon.dictionary.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.dictionary.api.dto.SysConfigDto;
import cloud.flystar.solon.dictionary.service.entity.SysConfig;
import org.springframework.stereotype.Service;


@Service
public class SysConfigDtoConvert extends DTOConvert<SysConfig,SysConfigDto> {
    @Override
    public SysConfigDto doForward(SysConfig sysConfig) {
        if(sysConfig == null){
            return null;
        }
        SysConfigDto dto = new SysConfigDto();
        dto.setSysConfigId(sysConfig.getSysConfigId())
                .setConfigKey(sysConfig.getConfigKey())
                .setConfigName(sysConfig.getConfigName())
                .setConfigValue(sysConfig.getConfigValue())
                .setConfigType(sysConfig.getConfigType())
                .setEnableFlag(sysConfig.getEnableFlag())
                .setCreateTime(sysConfig.getCreateTime())
                .setCreateUserId(sysConfig.getCreateUserId())
                .setUpdateTime(sysConfig.getUpdateTime())
                .setUpdateUserId(sysConfig.getUpdateUserId());
        return dto;
    }

    @Override
    public SysConfig doBackward(SysConfigDto dto) {
        return super.defaultDoBackward(dto);
    }
}
