package cloud.flystar.solon.dictionary.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.dictionary.api.dto.SysDictDetailDto;
import cloud.flystar.solon.dictionary.service.entity.SysDictDetail;
import org.springframework.stereotype.Service;

@Service
public class SysDictDetailDtoConvert extends DTOConvert<SysDictDetail, SysDictDetailDto> {
    @Override
    public SysDictDetailDto doForward(SysDictDetail source) {
        if(source == null){
            return null;
        }

        SysDictDetailDto dto = new SysDictDetailDto();
        dto.setDictDetailId(source.getDictDetailId())
                .setDictId(source.getDictId())
                .setDictCode(source.getDictCode())
                .setDictLabel(source.getDictLabel())
                .setDictIndex(source.getDictIndex())
                .setDefaultFlag(source.getDefaultFlag())
                .setEnableFlag(source.getEnableFlag())
                .setRemark(source.getRemark())
                .setCreateTime(source.getCreateTime())
                .setCreateUserId(source.getCreateUserId())
                .setUpdateTime(source.getUpdateTime())
                .setUpdateUserId(source.getUpdateUserId());
        return dto;    }

    @Override
    public SysDictDetail doBackward(SysDictDetailDto sysDictDetailDto) {
        throw new AssertionError("不支持逆向转化方法!");
    }
}
