package cloud.flystar.solon.dictionary.service;

import cloud.flystar.solon.commons.bean.dto.user.UserDataResourceScope;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.commons.pool.ThreadContextKey;
import cloud.flystar.solon.commons.pool.ThreadContextUtil;
import cloud.flystar.solon.dictionary.api.dto.mdm.MdmGbT2260Dto;
import cloud.flystar.solon.dictionary.service.entity.MdmGbT2260;
import cloud.flystar.solon.dictionary.service.inner.MdmGbT2260Service;
import cn.hutool.core.collection.ListUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.plugins.pagination.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertTrue;

@Slf4j
@SpringBootTest(classes= JunitApp.class,properties="classpath:/application.yml")
@TestMethodOrder (MethodOrderer.OrderAnnotation. class )
@DisplayName("行政区测试")
class MdmGbT2260ApiImplTest {
    @Resource
    private MdmGbT2260ApiImpl mdmGbT2260ApiImpl;

    @Resource
    private MdmGbT2260Service mdmGbT2260Service;

    @BeforeEach
    public void beforeEach(){
        ThreadContextUtil.initContext();
        ThreadContextUtil.put(ThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID,1L);

        UserSessionInfo userSessionInfo = new UserSessionInfo();
        userSessionInfo.setUserId(1L);
        userSessionInfo.setUserName("admin");
        userSessionInfo.setDeptIds(ListUtil.toList(1L));
        userSessionInfo.setManagementDeptIds(ListUtil.toList(1L,2L,3L));

        UserDataResourceScope userDataResourceScope = new UserDataResourceScope();
        userDataResourceScope.setDataResourceKey("/data/mdm/gbt2260");
        userDataResourceScope.setDataScopeCodes(ListUtil.toList("deptChild","deptCurrent","creator"));
        userSessionInfo.setUserDataResourceScopes(ListUtil.toList(userDataResourceScope));
        Optional<UserSessionInfo> optional  = Optional.of(userSessionInfo);
        ThreadContextUtil.put(ThreadContextKey.FRAMEWORK_CONTEXT_USER_SESSION,optional);
    }

    @AfterEach
    public void AfterEach(){
        ThreadContextUtil.clearContext();
    }


    @RepeatedTest(value = 10)
    @DisplayName("查询所有省份")
    @Order(1)
    void listProvince() {
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listProvince();
        assertTrue(list.size()>30);
    }

    @Test
    @DisplayName("根据省份查询城市")
    @Order(2)
    void listCity() {
        //山东
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listCity("370000");
        assertTrue(list.size() == 16);
    }

    @Test
    @DisplayName("根据城市查询区域")
    @Order(3)
    void listDistrict() {
        //青岛市
        List<MdmGbT2260Dto> list = mdmGbT2260ApiImpl.listDistrict("370200");
        assertTrue(list.size() == 10);
    }

    @Test
    @DisplayName("根据父级别编码查询子编码")
    @Order(4)
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
    @DisplayName("根据编码查询")
    @Order(5)
    void getByAreaCode(String areaCode,String areaName) {
        MdmGbT2260Dto mdmGbT2260Dto = mdmGbT2260ApiImpl.getByAreaCode(areaCode);
        assertTrue(mdmGbT2260Dto.getAreaName().equals(areaName));
    }


    @Test
    @DisplayName("分页查询")
    @Order(6)
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


    @RepeatedTest(10)
    @DisplayName("分页查询2")
    @Order(8)
    void page2(){
        Page page = new Page();
        page.setOptimizeCountSql(false);
        LambdaQueryChainWrapper<MdmGbT2260> queryChainWrapper = mdmGbT2260Service.lambdaQuery().eq(MdmGbT2260::getAreaCode, "370200");
        page = mdmGbT2260Service.pageByDataScope(page,queryChainWrapper);
        log.info("========page========");
        log.info(JsonUtil.jsonPretty(page));

    }
}