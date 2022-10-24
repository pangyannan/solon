package cloud.flystar.solon.dictionary.api;

import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;

import java.util.List;

/**
 * 中华人民共和国行政区划代码 服务接口
 */
public interface MdmGbT2260Api {
    /**
     * 所有省
     * @return
     */
    List<MdmGbT2260Dto> listProvince();

    /**
     * 根据省编码查询市
     * @param provinceAreaCode 省编码
     * @return
     */
    List<MdmGbT2260Dto> listCity(String provinceAreaCode);

    /**
     * 根据市编码查询 县/区
     * @param cityAreaCode 市编码
     * @return
     */
    List<MdmGbT2260Dto> listDistrict(String cityAreaCode);


    /**
     * 根据父级编码查询行政区域
     * @param parentCode
     * @return
     */
    List<MdmGbT2260Dto> listByParentCode(String parentCode);

}
