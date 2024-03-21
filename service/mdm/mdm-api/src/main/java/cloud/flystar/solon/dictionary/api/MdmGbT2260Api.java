package cloud.flystar.solon.dictionary.api;

import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;

import java.util.List;

/**
 * 中华人民共和国行政区划代码 服务接口
 */
public interface MdmGbT2260Api {
    /**
     * 所有省
     * @return 行政区数据
     */
    List<MdmGbT2260Dto> listProvince();

    /**
     * 根据省编码查询下属市
     * @param provinceAreaCode 省编码
     * @return 行政区数据
     */
    List<MdmGbT2260Dto> listCity(String provinceAreaCode);

    /**
     * 根据市编码查询下属县/区
     * @param cityAreaCode 市编码
     * @return 行政区数据集合
     */
    List<MdmGbT2260Dto> listDistrict(String cityAreaCode);


    /**
     * 根据父级编码查询下属行政区域
     * @param parentCode
     * @return 行政区数据集合
     */
    List<MdmGbT2260Dto> listByParentCode(String parentCode);

    /**
     * 根据行政区编码编码查询
     * @param areaCode 行政区编码
     * @return 行政区数据
     */
    MdmGbT2260Dto getByAreaCode(String areaCode);

    /**
     * 根据行政区编码编码集合查询
     * @param areaCodeList 行政区编码集合
     * @return 行政区数据集合
     */
    List<MdmGbT2260Dto> listByAreaCode(List<String> areaCodeList);
}
