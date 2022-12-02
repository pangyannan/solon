package cloud.flystar.solon.dictionary.service.convert;

import cloud.flystar.solon.commons.bean.dto.DTOConvert;
import cloud.flystar.solon.dictionary.api.dto.SysDictDetailDto;
import cloud.flystar.solon.dictionary.api.dto.SysDictDto;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.dictionary.service.entity.SysDictDetail;
import cn.hutool.core.collection.ListUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;


@Service
public class SysDictDtoConvert extends DTOConvert<SysDict, SysDictDto> {
    @Resource
    private SysDictDetailDtoConvert sysDictDetailDtoConvert;

    @Override
    public SysDictDto doForward(SysDict source) {
        if(source == null){
            return null;
        }

        SysDictDto dto = new SysDictDto();
        dto.setDictId(source.getDictId())
                .setDictType(source.getDictType())
                .setDictName(source.getDictName())
                .setDictFieldOpinions(source.getDictFieldOpinions())
                .setEnableFlag(source.getEnableFlag())
                .setRemark(source.getRemark())
                .setCreateTime(source.getCreateTime())
                .setCreateUserId(source.getCreateUserId())
                .setUpdateTime(source.getUpdateTime())
                .setUpdateUserId(source.getUpdateUserId())
                .setDetailList(null);
        return dto;
    }

    public SysDictDto doForward(SysDict source, List<SysDictDetail> sysDictDetailList) {
        SysDictDto sysDictDto = this.doForward(source);
        if(sysDictDto == null){
            return null;
        }

        List<SysDictDetail> sysDictDetails = Optional.ofNullable(sysDictDetailList).orElse(ListUtil.empty());
        List<SysDictDetailDto> sysDictDetailDtoList = sysDictDetailDtoConvert.doForward(sysDictDetails);
        sysDictDto.setDetailList(sysDictDetailDtoList);

        return sysDictDto;
    }

    @Override
    public SysDict doBackward(SysDictDto dto) {
        return super.defaultDoBackward(dto);
    }
}
