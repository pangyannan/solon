package cloud.flystar.solon.dictionary.api;

import cloud.flystar.solon.dictionary.api.dto.SysDictDetailDto;
import cloud.flystar.solon.dictionary.api.dto.SysDictDto;

import java.util.List;

/**
 * 字典服务
 */
public interface SysDictApi {
    /**
     * 根据字典类型编码查询字典数据
     * 1.包含非启用的字典类型
     * 2.包含非启用的字典键值
     * @param dictType 字典类型编码
     * @return 字典数据
     */
    SysDictDto getByDictType(String dictType);

    /**
     * 根据字典类型编码查询字典数据
     * 1.包含非启用的字典类型
     * 2.包含非启用的字典键值
     * @param dictTypes 字典类型集合
     * @return 字典数据集合
     */
    List<SysDictDto> listByDictTypes(List<String> dictTypes);

    /**
     * 根据字典类型编码查询字典数据
     * 1.只包含启用的字典类型
     * 2.只含启用的字典键值
     * @param dictType 字典类型编码
     * @return 字典数据
     */
    SysDictDto getByDictTypeAndEnable(String dictType);

    /**
     * 根据字典类型编码查询字典数据
     * 1.只包含启用的字典类型
     * 2.只含启用的字典键值
     * @param dictTypes 字典类型集合
     * @return 字典数据集合
     */
    List<SysDictDto> listByDictTypesAndEnable(List<String> dictTypes);


    /**
     * 根据字典类型编码查询字典明细数据
     * @param dictType 字典类型编码
     * @return 字典明细数据集合
     */
    List<SysDictDetailDto> listDetail(String dictType);
}
