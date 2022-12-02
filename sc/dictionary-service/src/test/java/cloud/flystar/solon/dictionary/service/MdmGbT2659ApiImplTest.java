package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.dictionary.api.MdmGbT2659Api;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2659Dto;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;


@Slf4j
@SpringBootTest(classes= JunitApp.class,properties="classpath:/application.yml")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
class MdmGbT2659ApiImplTest {
    @Resource
    MdmGbT2659Api mdmGbT2659Api;

    @Test
    @Order(10)
    void listAll() {
        List<MdmGbT2659Dto> list = mdmGbT2659Api.listAll();
        Assertions.assertTrue(list.size() > 200);
    }

    @Order(20)
    @ParameterizedTest
    @ValueSource(strings = { "CN", "US", "JP" })
    void getByCountryCode2(String code2) {
        MdmGbT2659Dto dto = mdmGbT2659Api.getByCountryCode2(code2);
        log.debug(dto.toString());
        assertTrue(dto.getCountryCode2().equals(code2));
    }

    @Order(30)
    @ParameterizedTest
    @ValueSource(strings = { "CHN", "GBR", "USA", "RUS" })
    void getByCountryCode3(String code3) {
        MdmGbT2659Dto dto = mdmGbT2659Api.getByCountryCode3(code3);
        log.debug(dto.toString());
        assertTrue(dto.getCountryCode3().equals(code3));

    }

    @Order(40)
    @ParameterizedTest
    @CsvSource( {
            "156, 中国",
            "250, 法国",
    })
    void getByCountryNumber(String number,String shortNameCn) {
        MdmGbT2659Dto dto = mdmGbT2659Api.getByCountryNumber(number);
        log.debug(dto.toString());

        assertTrue(dto.getCountryNumber().equals(number));
        assertTrue(dto.getCountryShortNameCn().equals(shortNameCn));
    }

    @Order(50)
    @RepeatedTest(value = 10)
    void searchByKeyWorld() {
        List<MdmGbT2659Dto> blankList = mdmGbT2659Api.searchByKeyWorld("");
        assertTrue(blankList.size() == 0);

        List<MdmGbT2659Dto> lengthList = mdmGbT2659Api.searchByKeyWorld(RandomUtil.randomString(1));
        assertTrue(lengthList.size() == 0);

        List<MdmGbT2659Dto> cnList = mdmGbT2659Api.searchByKeyWorld("中国");
        log.debug(JsonUtil.json(cnList));

        assertTrue(cnList.size() > 0);

        assertTrue(cnList.stream().filter(t-> StrUtil.contains(t.getCountryShortNameCn(),"中国")).count() > 0);


    }
}