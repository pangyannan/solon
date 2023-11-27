package cloud.flystar.solon.core.config.cluster;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.convert.DurationStyle;
import org.springframework.context.annotation.Configuration;


@Configuration
@ConfigurationProperties(prefix = "cluster.node")
@Data
public class ClusterProperties {

    private Boolean single = Boolean.TRUE;

    /**
     * 数据中心ID
     * 0～31 默认0
     */
    private Integer dataCenterId = 0;

    /**
     * nodeInfo redis 过期时间
     * @see DurationStyle
     * 默认 3600s
     */
    private Integer workIdRedisTimeOut = 60;


    /**
     * nodeInfo redis 心跳周期
     * @see DurationStyle
     * 默认 10s
     */
    private Integer workIdRedisHeartBeat = 10;
}
