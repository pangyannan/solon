package cloud.flystar.solon.dictionary.service.inner;

import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.dictionary.service.JunitApp;
import cloud.flystar.solon.dictionary.service.entity.SysDict;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

@Slf4j
@SpringBootTest(classes= JunitApp.class,properties="classpath:/application.yml")
class SysDictServiceTest {
    @Resource
    private SysDictService sysDictService;

    @Test
    void page() {

    }
}