package cloud.flystar.solon.core.config.cluster;


import cloud.flystar.solon.core.service.CurrentNodeService;
import cloud.flystar.solon.core.service.impl.cluster.ClusterRedisModelCurrentNodeServiceImpl;
import cloud.flystar.solon.core.service.impl.cluster.SingleModelCurrentNodeServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ClusterConfig {
    @Bean
    public CurrentNodeService currentNodeService(ClusterProperties clusterProperties){
        Boolean isSingle = clusterProperties.getSingle();
        if(isSingle){
            return new SingleModelCurrentNodeServiceImpl();
        }else{
            return new ClusterRedisModelCurrentNodeServiceImpl();
        }
    }
}
