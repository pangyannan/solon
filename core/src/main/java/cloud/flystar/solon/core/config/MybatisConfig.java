package cloud.flystar.solon.core.config;

import cloud.flystar.solon.core.service.CurrentNodeService;
import cloud.flystar.solon.core.service.FrameworkContextService;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.core.incrementer.DefaultIdentifierGenerator;
import com.baomidou.mybatisplus.core.incrementer.IdentifierGenerator;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.apache.ibatis.reflection.MetaObject;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;

@Configuration
@MapperScan("cloud.flystar.solon.**.mapper")
public class MybatisConfig {
    /**
     * 新的分页插件,一缓和二缓遵循mybatis的规则,需要设置 MybatisConfiguration#useDeprecatedExecutor = false 避免缓存出现问题(该属性会在旧插件移除后一同移除)
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());
        return interceptor;
    }


    //雪花算法生成器
    @Bean
    public IdentifierGenerator idGenerator(CurrentNodeService currentNodeService) {
        int workerId = currentNodeService.workerId();
        int dataCenterId = currentNodeService.dataCenterId();
        DefaultIdentifierGenerator defaultIdentifierGenerator = new DefaultIdentifierGenerator(workerId, dataCenterId);
        IdWorker.setIdentifierGenerator(defaultIdentifierGenerator);
        return defaultIdentifierGenerator;
    }


    //创建时间修改时间填充器
    @Bean
    public MetaObjectHandler myMetaObjectHandler(FrameworkContextService frameworkContextService) {
        return new MetaObjectHandler(){
            @Override
            public void insertFill(MetaObject metaObject) {
                this.strictInsertFill(metaObject, "createTime", () -> LocalDateTime.now(), LocalDateTime.class);
                this.strictInsertFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class);
                this.strictInsertFill(metaObject, "createUserId", () -> frameworkContextService.getLoginIdDefaultNull(), Long.class);
                this.strictInsertFill(metaObject, "updateUserId", () -> frameworkContextService.getLoginIdDefaultNull(), Long.class);
            }

            @Override
            public void updateFill(MetaObject metaObject) {
                this.strictInsertFill(metaObject, "updateTime", () -> LocalDateTime.now(), LocalDateTime.class);
                this.strictInsertFill(metaObject, "updateUserId", () -> frameworkContextService.getLoginIdDefaultNull(), Long.class);
            }
        };
    }

}
