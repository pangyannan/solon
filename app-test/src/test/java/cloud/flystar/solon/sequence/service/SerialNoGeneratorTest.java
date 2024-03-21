package cloud.flystar.solon.sequence.service;

import cloud.flystar.solon.JunitApp;
import cloud.flystar.solon.commons.bean.dto.user.UserDataResourceScope;
import cloud.flystar.solon.commons.bean.dto.user.UserSessionInfo;
import cloud.flystar.solon.commons.pool.ThreadContext;
import cloud.flystar.solon.core.constant.WebThreadContextKey;
import cn.hutool.core.collection.ListUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.*;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.Optional;


/**
 * 流水号生成器核心入口服务
 */
@Slf4j
@SpringBootTest(classes= JunitApp.class, properties="classpath:/application.yml")
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class SerialNoGeneratorTest {

    @Resource
    SerialNoGenerator serialNoGenerator;


    @BeforeEach
    public void beforeEach(){
        ThreadContext.initContext();
        ThreadContext.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_LOGINID,1L);

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
        ThreadContext.put(WebThreadContextKey.FRAMEWORK_CONTEXT_USER_SESSION,optional);
    }

    @AfterEach
    public void AfterEach(){
        ThreadContext.clearContext();
    }



    @Test
    @Order(1)
    @DisplayName("获取不存在的bizCode=Order序列号")
    void getSerialNoOrder() throws Exception {
        String order = serialNoGenerator.getSerialNo("Order");
        log.debug(order);
    }

    @Test
    @Order(2)
    @RepeatedTest(100)
    @DisplayName("获取存在的bizCode=Test序列号")
    void getSerialNoTest() throws Exception {
        for (int i = 0; i < 10000; i++) {
            String order = serialNoGenerator.getSerialNo("Test");
            log.debug(order);
        }
    }
}
