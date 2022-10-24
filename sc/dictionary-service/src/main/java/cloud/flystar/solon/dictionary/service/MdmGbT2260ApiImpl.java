package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.dictionary.api.MdmGbT2260Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260AreaLevelEnum;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import cloud.flystar.solon.dictionary.service.convert.MdmGbT2260DtoConvert;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2260Service;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class MdmGbT2260ApiImpl implements MdmGbT2260Api {
    @Resource
    private MdmGbT2260Service mdmGbT2260Service;
    @Resource
    private MdmGbT2260DtoConvert mdmGbT2260DtoConvert;

    @Override
    public List<MdmGbT2260Dto> listProvince() {
        List<MdmGbT2260> list = mdmGbT2260Service.lambdaQuery()
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.Province.getCode())
                .list();
        return mdmGbT2260DtoConvert.doForward(list);
    }

    @Override
    public List<MdmGbT2260Dto> listCity(String provinceAreaCode) {
        if(StrUtil.isBlank(provinceAreaCode)){
            return ListUtil.empty();
        }
        List<MdmGbT2260> list = mdmGbT2260Service.lambdaQuery()
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.City.getCode())
                .eq(MdmGbT2260::getParentCode,provinceAreaCode)
                .list();
        return mdmGbT2260DtoConvert.doForward(list);
    }

    @Override
    public List<MdmGbT2260Dto> listDistrict(String cityAreaCode) {
        if(StrUtil.isBlank(cityAreaCode)){
            return ListUtil.empty();
        }
        List<MdmGbT2260> list = mdmGbT2260Service.lambdaQuery()
                .eq(MdmGbT2260::getAreaLevel, MdmGbT2260AreaLevelEnum.District.getCode())
                .eq(MdmGbT2260::getParentCode,cityAreaCode)
                .list();
        return mdmGbT2260DtoConvert.doForward(list);
    }

    @Override
    public List<MdmGbT2260Dto> listByParentCode(String parentCode) {
        if(StrUtil.isBlank(parentCode)){
            //没有父级，表示查询省级别
            return this.listProvince();
        }
        List<MdmGbT2260> list = mdmGbT2260Service.lambdaQuery()
                .eq(MdmGbT2260::getParentCode,parentCode)
                .list();
        return mdmGbT2260DtoConvert.doForward(list);
    }
}
