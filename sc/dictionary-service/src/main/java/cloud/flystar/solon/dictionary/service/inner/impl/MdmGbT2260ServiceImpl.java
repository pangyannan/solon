package cloud.flystar.solon.dictionary.service.inner.impl;

import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260AreaLevelEnum;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2260Service;
import cloud.flystar.solon.dictionary.service.mapper.MdmGbT2260Mapper;
import cloud.flystar.solon.framework.service.impl.BaseServiceImpl;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class MdmGbT2260ServiceImpl extends BaseServiceImpl<MdmGbT2260Mapper, MdmGbT2260> implements MdmGbT2260Service {
    @Override
    public List<MdmGbT2260> listProvince() {
        return this.lambdaQuery().eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.Province.getCode()).list();
    }

    @Override
    public List<MdmGbT2260> listCityByProvinceCode(String provincesCode) {
        if(StrUtil.isBlank(provincesCode)){
            return ListUtil.empty();
        }
        return this.lambdaQuery()
                .eq(MdmGbT2260::getParentCode,provincesCode)
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.City.getCode()).list();
    }

    @Override
    public List<MdmGbT2260> listDistrictByCityCode(String cityCode) {
        if(StrUtil.isBlank(cityCode)){
            return ListUtil.empty();
        }
        return this.lambdaQuery()
                .eq(MdmGbT2260::getParentCode,cityCode)
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.District.getCode()).list();
    }
}
