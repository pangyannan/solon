package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.dictionary.api.MdmGbT2260Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;


@Slf4j
@SpringBootTest(classes= JunitApp.class,properties="classpath:/application.yml")
class MdmGbT2260ApiImplTest {
    @Resource
    private MdmGbT2260Api mdmGbT2260Api;

    @RepeatedTest(value = 10)
    void listProvince() {
        List<MdmGbT2260Dto> list = mdmGbT2260Api.listProvince();
        Assertions.assertTrue(list.size()>30);
    }

    @Test
    void listCity() {
        //山东
        List<MdmGbT2260Dto> list = mdmGbT2260Api.listCity("370000");
        Assertions.assertTrue(list.size() == 16);
    }

    @Test
    void listDistrict() {
        //青岛市
        List<MdmGbT2260Dto> list = mdmGbT2260Api.listDistrict("370200");
        Assertions.assertTrue(list.size() == 10);
    }

    @Test
    void listByParentCode() {
        List<MdmGbT2260Dto> shandong = mdmGbT2260Api.listByParentCode("370000");
        Assertions.assertTrue(shandong.size() == 16);


        List<MdmGbT2260Dto> qingdao = mdmGbT2260Api.listByParentCode("370200");
        Assertions.assertTrue(qingdao.size() == 10);



    }
}