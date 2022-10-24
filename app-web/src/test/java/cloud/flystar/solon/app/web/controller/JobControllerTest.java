package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.dictionary.api.MdmGbT2260Api;
import cloud.flystar.solon.dictionary.api.MdmGbT2659Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2659Dto;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@SpringBootTest
class JobControllerTest {
    @Resource
    private MdmGbT2659Api mdmGbT2659Api;

    @Resource
    private MdmGbT2260Api mdmGbT2260Api;


    @Test
    public void listAllTest(){
        List<MdmGbT2659Dto> list = mdmGbT2659Api.listAll();
        Assertions.assertTrue(list.size() == 245);

        List<MdmGbT2260Dto> mdmGbT2260Dtos = mdmGbT2260Api.listProvince();
        Assertions.assertTrue(mdmGbT2260Dtos.size() > 1);

    }

    @Test
    public void getByCountryCode2Test(){
        MdmGbT2659Dto cn = mdmGbT2659Api.getByCountryCode2("CN");
        Assertions.assertTrue(cn.getCountryCode2().equals("CN"));

        MdmGbT2659Dto blankDto = mdmGbT2659Api.getByCountryCode2("");
        Assertions.assertTrue(blankDto == null);


        MdmGbT2659Dto nullDto = mdmGbT2659Api.getByCountryCode2(null);
        Assertions.assertTrue(nullDto == null);
    }
}