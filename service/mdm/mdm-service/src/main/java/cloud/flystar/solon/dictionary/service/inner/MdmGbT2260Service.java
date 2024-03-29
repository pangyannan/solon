package cloud.flystar.solon.dictionary.service.inner;

import cloud.flystar.solon.core.service.IBaseService;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

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





    Page<MdmGbT2260> pageByDataScope(Page<MdmGbT2260> page, LambdaQueryChainWrapper<MdmGbT2260> queryWrapper);

}
