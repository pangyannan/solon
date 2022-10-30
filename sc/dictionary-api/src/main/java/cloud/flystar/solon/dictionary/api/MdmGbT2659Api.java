package cloud.flystar.solon.dictionary.api;

import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2659Dto;

import java.util.List;

/**
 * 世界各国和地区名称代码 服务接口
 */
public interface MdmGbT2659Api {
    /**
     * 查询所有国家和地区
     * @return 所有国家和地区数据集合
     */
    List<MdmGbT2659Dto> listAll();

    /**
     * 根据国家2位字母查询国家数据
     * @param countryCode2 国家2位字母
     * @return 国家和地区
     */
    MdmGbT2659Dto getByCountryCode2(String countryCode2);

    /**
     * 根据国家2位字母集合查询国家数据
     * @param countryCode2List 国家2位字母集合
     * @return 国家和地区列表
     */
    List<MdmGbT2659Dto> listByCountryCode2(List<String> countryCode2List);


    /**
     * 根据国家3位字母查询国家数据
     * @param countryCode3 国家3位字母
     * @return 国家和地区
     */
    MdmGbT2659Dto getByCountryCode3(String countryCode3);

    /**
     * 根据国家3位数字代码查询国家数据
     * @param countryNumber 国家3位数字代码
     * @return 国家和地区
     */
    MdmGbT2659Dto getByCountryNumber(String countryNumber);

    /**
     * 根据关键字搜索国家
     * @param keyWorld 关键字 至少一个字符
     * @return 国家和地区集合
     */
    List<MdmGbT2659Dto> searchByKeyWorld(String keyWorld);
}
