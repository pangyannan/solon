package cloud.flystar.solon.dictionary.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import org.springframework.stereotype.Service;


@Service
public class MdmGbT2260DtoConvert extends DTOConvert<MdmGbT2260, MdmGbT2260Dto> {
    @Override
    public MdmGbT2260Dto doForward(MdmGbT2260 source) {
        if(source == null){
            return null;
        }
        MdmGbT2260Dto dto = new MdmGbT2260Dto();
        dto.setAreaCode(source.getAreaCode())
                .setAreaName(source.getAreaName())
                .setParentCode(source.getParentCode())
                .setAreaLevel(source.getAreaLevel());

        return dto;
    }

    @Override
    public MdmGbT2260 doBackward(MdmGbT2260Dto dto) {
        return super.defaultDoBackward(dto);
    }
}
