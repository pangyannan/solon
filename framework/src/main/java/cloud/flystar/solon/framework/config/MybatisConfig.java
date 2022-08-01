package cloud.flystar.solon.framework.config;

import cloud.flystar.solon.framework.service.CurrentNodeService;
import cloud.flystar.solon.framework.service.SingleModelCurrentNodeServiceImpl;
import com.baomidou.mybatisplus.core.incrementer.DefaultIdentifierGenerator;
import com.baomidou.mybatisplus.core.incrementer.IdentifierGenerator;
import com.baomidou.mybatisplus.core.toolkit.Sequence;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.net.InetAddress;

@Configuration
@MapperScan("cloud.flystar.solon.**.mapper")
public class MybatisConfig {

    @Bean
    public CurrentNodeService currentNodeService(){
        return new SingleModelCurrentNodeServiceImpl();
    }

    //雪花算法生成器
    @Bean
    public IdentifierGenerator idGenerator(CurrentNodeService currentNodeService) {
        if(currentNodeService.workerId() >= 0 && currentNodeService.dataCenterId() >= 0){
            return new DefaultIdentifierGenerator(currentNodeService.workerId(),currentNodeService.dataCenterId());
        }
        return new DefaultIdentifierGenerator();
    }
}
