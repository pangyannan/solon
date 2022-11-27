package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2260Service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

@Slf4j
@SpringBootTest(classes= JunitApp.class,properties="classpath:/application.yml")
class MdmGbT2260ApiImplTest {
    @Resource
    private MdmGbT2260ApiImpl mdmGbT2260ApiImpl;

    @Resource
    private MdmGbT2260Service mdmGbT2260Service;

    @RepeatedTest(value = 10)
    void listProvince() {
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listProvince();
        assertTrue(list.size()>30);
    }

    @Test
    void listCity() {
        //山东
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listCity("370000");
        assertTrue(list.size() == 16);
    }

    @Test
    void listDistrict() {
        //青岛市
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listDistrict("370200");
        assertTrue(list.size() == 10);
    }

    @Test
    void listByParentCode() {
        List<MdmGbT2260Dto> shandong = mdmGbT2260ApiImpl.listByParentCode("370000");
        assertTrue(shandong.size() == 16);


        List<MdmGbT2260Dto> qingdao = mdmGbT2260ApiImpl.listByParentCode("370200");
        assertTrue(qingdao.size() == 10);
    }

    @ParameterizedTest
    @CsvSource( {
            "370000, 山东省",
            "370200, 青岛市",
    })
    void getByAreaCode(String areaCode,String areaName) {
        MdmGbT2260Dto mdmGbT2260Dto = mdmGbT2260ApiImpl.getByAreaCode(areaCode);
        assertTrue(mdmGbT2260Dto.getAreaName().equals(areaName));
    }


    @Test
    void page(){
        IPage page = new Page();
        page = mdmGbT2260Service.page(page);
        log.info("========page========");
        log.info(JsonUtil.jsonPretty(page));

        PageDTO pageDTO = new PageDTO();
        pageDTO = mdmGbT2260Service.page(pageDTO);
        log.info("========pageDTO========");
        log.info(JsonUtil.jsonPretty(pageDTO));
    }

    @Test
    void page2(){
        Page page = new Page();
        page.setOptimizeCountSql(false);
        LambdaQueryChainWrapper<MdmGbT2260> queryChainWrapper = mdmGbT2260Service.lambdaQuery().eq(MdmGbT2260::getAreaCode, "370200");
        page = mdmGbT2260Service.pageByDataScope(page,queryChainWrapper);
        log.info("========page========");
        log.info(JsonUtil.jsonPretty(page));

    }
}