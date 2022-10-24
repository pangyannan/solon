package cloud.flystar.solon.dictionary.service;


import cloud.flystar.solon.dictionary.api.MdmGbT2659Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2659Dto;
import cloud.flystar.solon.dictionary.service.convert.MdmGbT2659DtoConvert;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2659;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2659Service;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MdmGbT2659ApiImpl implements MdmGbT2659Api {
    @Resource
    private MdmGbT2659Service mdmGbT2659Service;
    @Resource
    private MdmGbT2659DtoConvert mdmGbT2659DtoConvert;

    @Override
    public List<MdmGbT2659Dto> listAll() {
        List<MdmGbT2659> list = mdmGbT2659Service.list();
        return mdmGbT2659DtoConvert.doForward(list);
    }

    @Override
    public MdmGbT2659Dto getByCountryCode2(String countryCode2) {
        if(StrUtil.isBlank(countryCode2)){
            return null;
        }
        MdmGbT2659 mdmGbT2659 = mdmGbT2659Service.lambdaQuery()
                .eq(MdmGbT2659::getCountryCode2, countryCode2)
                .one();
        return mdmGbT2659DtoConvert.doForward(mdmGbT2659);
    }

    @Override
    public MdmGbT2659Dto getByCountryCode3(String countryCode3) {
        if(StrUtil.isBlank(countryCode3)){
            return null;
        }
        MdmGbT2659 mdmGbT2659 = mdmGbT2659Service.lambdaQuery()
                .eq(MdmGbT2659::getCountryCode3, countryCode3)
                .one();
        return mdmGbT2659DtoConvert.doForward(mdmGbT2659);
    }

    @Override
    public MdmGbT2659Dto getByCountryNumber(String countryNumber) {
        if(StrUtil.isBlank(countryNumber)){
            return null;
        }
        MdmGbT2659 mdmGbT2659 = mdmGbT2659Service.lambdaQuery()
                .eq(MdmGbT2659::getCountryNumber, countryNumber)
                .one();
        return mdmGbT2659DtoConvert.doForward(mdmGbT2659);
    }

    @Override
    public List<MdmGbT2659Dto> searchByKeyWorld(String keyWorld) {
        if(StrUtil.length(keyWorld) <= 1){
            return ListUtil.empty();
        }
        List<MdmGbT2659> list = mdmGbT2659Service.lambdaQuery()
                .like(MdmGbT2659::getCountryCode2, keyWorld)
                .or().like(MdmGbT2659::getCountryCode3, keyWorld)
                .or().like(MdmGbT2659::getCountryNameEn, keyWorld)
                .or().like(MdmGbT2659::getCountryShortNameEn, keyWorld)
                .or().like(MdmGbT2659::getCountryShortNameCn, keyWorld)
                .list();
        return mdmGbT2659DtoConvert.doForward(list);
    }
}
