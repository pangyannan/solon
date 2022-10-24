package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.bean.constant.YesOrNo;
import cloud.flystar.solon.dictionary.api.SysDictApi;
import cloud.flystar.solon.dictionary.api.dto.SysDictDetailDto;
import cloud.flystar.solon.dictionary.api.dto.SysDictDto;
import cloud.flystar.solon.dictionary.service.convert.SysDictDtoConvert;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import cloud.flystar.solon.dictionary.service.entity.SysDictDetail;
import cloud.flystar.solon.dictionary.service.inner.SysDictDetailService;
import cloud.flystar.solon.dictionary.service.inner.SysDictService;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SysDictApiImpl implements SysDictApi {
    @Resource
    private SysDictService sysDictService;
    @Resource
    private SysDictDetailService sysDictDetailService;
    @Resource
    private SysDictDtoConvert sysDictDtoConvert;

    @Override
    public SysDictDto getByDictType(String dictType) {
        if(StrUtil.isBlank(dictType)){
            return null;
        }
        SysDict sysDict = sysDictService.lambdaQuery().eq(SysDict::getDictType, dictType).one();
        if(sysDict == null){
            return null;
        }

        List<SysDictDetail> sysDictDetails = sysDictDetailService.lambdaQuery()
                .eq(SysDictDetail::getDictId, sysDict.getDictId())
                .orderByAsc(SysDictDetail::getDictIndex)
                .list();

        return sysDictDtoConvert.doForward(sysDict,sysDictDetails);
    }

    @Override
    public List<SysDictDto> listByDictTypes(List<String> dictTypes) {
        if(CollectionUtil.isEmpty(dictTypes)){
            return ListUtil.empty();
        }
        Set<String> dictTypeSet = dictTypes.stream().collect(Collectors.toSet());

        Assert.isTrue(CollectionUtil.size(dictTypeSet) <= 1000,"查询字典批次数量最高为{}",1000);

        if(CollectionUtil.size(dictTypeSet) <= 8){
            //如果集合较小，可以直接循环查询返回，也比较容易利用缓存
            return dictTypeSet.stream().map(this::getByDictType).collect(Collectors.toList());
        }

        //查询主信息
        List<SysDict> list = sysDictService.lambdaQuery().in(SysDict::getDictType, dictTypeSet).list();

        //查询明细
        Set<Long> dictIds = list.stream().map(SysDict::getDictId).collect(Collectors.toSet());
        List<SysDictDetail> sysDictDetails = sysDictDetailService.lambdaQuery()
                .in(SysDictDetail::getDictId, dictIds)
                .orderByAsc(SysDictDetail::getDictIndex)
                .list();
        Map<Long, List<SysDictDetail>> sysDictDetailMap = sysDictDetails.stream().collect(Collectors.groupingBy(SysDictDetail::getDictId));

        List<SysDictDto> dtoList = new ArrayList<>(list.size());
        for (SysDict sysDict : list) {
            List<SysDictDetail> sysDictDetailsByDictId = sysDictDetailMap.get(sysDict.getDictId());
            SysDictDto sysDictDto = sysDictDtoConvert.doForward(sysDict, sysDictDetailsByDictId);
            dtoList.add(sysDictDto);
        }

        return dtoList;
    }

    @Override
    public SysDictDto getByDictTypeAndEnable(String dictType) {
        SysDictDto sysDictDto = this.getByDictType(dictType);
        if(sysDictDto == null){
            return null;
        }

        if(YesOrNo.isYes(sysDictDto.getEnableFlag())){
            List<SysDictDetailDto> enableDetailList = Optional.ofNullable(sysDictDto.getDetailList())
                    .orElse(ListUtil.empty())
                    .stream()
                    .filter(t -> YesOrNo.isYes(t.getEnableFlag()))
                    .collect(Collectors.toList());
            sysDictDto.setDetailList(enableDetailList);

            return sysDictDto;
        }

        return null;

    }

    @Override
    public List<SysDictDto> listByDictTypesAndEnable(List<String> dictTypes) {
        List<SysDictDto> sysDictDtoList = this.listByDictTypes(dictTypes);

        List<SysDictDto> enableList = sysDictDtoList.stream().filter(t -> YesOrNo.isYes(t.getEnableFlag())).collect(Collectors.toList());
        for (SysDictDto sysDictDto : enableList) {
            List<SysDictDetailDto> enableDetailList = Optional.ofNullable(sysDictDto.getDetailList())
                    .orElse(ListUtil.empty())
                    .stream()
                    .filter(t -> YesOrNo.isYes(t.getEnableFlag()))
                    .collect(Collectors.toList());
            sysDictDto.setDetailList(enableDetailList);
        }
        return enableList;
    }

    @Override
    public List<SysDictDetailDto> listDetail(String dictType) {
        SysDictDto sysDictDto = this.getByDictType(dictType);
        if(sysDictDto == null){
            return ListUtil.empty();
        }
        return sysDictDto.getDetailList();
    }
}
