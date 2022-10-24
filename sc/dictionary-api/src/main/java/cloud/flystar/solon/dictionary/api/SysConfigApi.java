package cloud.flystar.solon.dictionary.api;


import cloud.flystar.solon.dictionary.api.dto.SysConfigDto;

import java.util.List;

/**
 * 配置服务
 */
public interface SysConfigApi {
    /**
     * 根据配置ID查询配置参数
     * @param sysConfigId 配置ID
     * @return 配置参数
     */
    SysConfigDto getById(Long sysConfigId);

    /**
     * 根据配置ID查询配置参数
     * @param sysConfigIds 配置ID集合
     * @return 配置参数集合
     */
    List<SysConfigDto> listByIds(List<Long> sysConfigIds);

    /**
     * 根据配置ID查询配置参数
     * @param configKey 配置Key
     * @return 配置参数
     */
    SysConfigDto getByConfigKey(String  configKey);

    /**
     * 根据配置ID查询配置参数
     * @param configKeys 配置Key集合
     * @return 配置参数集合
     */
    List<SysConfigDto> listByConfigKeys(List<String> configKeys);


    /**
     * 根据配置Key配置参数
     * @param configKey 配置Key
     * @return 配置参数
     */
    SysConfigDto getByConfigKeyAndEnable(String  configKey);

    /**
     * 根据配置Key集合查询值集合
     * @param configKeys 配置Key集合
     * @return 配置参数集合
     */
    List<SysConfigDto> listByConfigKeysAndEnable(List<String> configKeys);


}
