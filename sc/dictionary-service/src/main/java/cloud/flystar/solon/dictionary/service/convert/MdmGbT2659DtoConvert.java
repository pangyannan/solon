package cloud.flystar.solon.dictionary.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2659Dto;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2659;
import org.springframework.stereotype.Service;

@Service
public class MdmGbT2659DtoConvert extends DTOConvert<MdmGbT2659,MdmGbT2659Dto> {
    @Override
    public MdmGbT2659Dto doForward(MdmGbT2659 source) {
        if(source == null){
            return null;
        }
        MdmGbT2659Dto target = new MdmGbT2659Dto();
        target.setCountryCode2(source.getCountryCode2())
                .setCountryCode3(source.getCountryCode3())
                .setCountryNumber(source.getCountryNumber())
                .setCountryShortNameEn(source.getCountryShortNameEn())
                .setCountryNameEn(source.getCountryNameEn())
                .setCountryShortNameCn(source.getCountryShortNameCn());
        return target;
    }

    @Override
    public MdmGbT2659 doBackward(MdmGbT2659Dto dto) {
        return super.defaultDoBackward(dto);
    }
}
