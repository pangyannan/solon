package cloud.flystar.solon.dictionary.service.inner;

import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.framework.service.IBaseService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;

import java.util.List;

/**
 * GBT2260-2007中华人民共和国行政区划代码 服务
 */
public interface MdmGbT2260Service extends IBaseService<MdmGbT2260> {
    /**
     * 所有省级行政区
     */
    List<MdmGbT2260> listProvince();


    /**
     * 根据省级别行政区代码查询市级别行政区
     */
    List<MdmGbT2260> listCityByProvinceCode(String provincesCode);

    /**
     * 根据市级别代码查询县/区级别行政区
     */
    List<MdmGbT2260> listDistrictByCityCode(String cityCode);





    IPage<MdmGbT2260> pageByDataScope(IPage<MdmGbT2260> page, LambdaQueryChainWrapper<MdmGbT2260> queryWrapper);

}
