package cloud.flystar.solon.framework.config.cluster;


import cloud.flystar.solon.framework.service.CurrentNodeService;
import cloud.flystar.solon.framework.service.impl.cluster.ClusterRedisModelCurrentNodeServiceImpl;
import cloud.flystar.solon.framework.service.impl.cluster.SingleModelCurrentNodeServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ClusterConfig {
    @Bean
    public CurrentNodeService currentNodeService(){
        return new ClusterRedisModelCurrentNodeServiceImpl();
    }


}
