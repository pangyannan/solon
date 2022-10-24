package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.dictionary.api.MdmGbT2260Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;


@Slf4j
@SpringBootTest(classes=TestApp.class,properties="application.yml")
class MdmGbT2260ApiImplTest {
    @Resource
    private MdmGbT2260Api mdmGbT2260Api;

    @Test
    void listProvince() {
        List<MdmGbT2260Dto> list = mdmGbT2260Api.listProvince();
        Assertions.assertTrue(list.size()>30);
    }

    @Test
    void listCity() {
    }

    @Test
    void listDistrict() {
    }

    @Test
    void listByParentCode() {
    }
}