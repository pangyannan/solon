package cloud.flystar.solon.core.config.http;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConfigurationProperties(prefix = "http.client")
@Data
public class HttpClientConfig {
    //设置整个连接池最大连接数 根据自己的场景决定
    private Integer poolMaxSize ;
    //路由是对maxTotal的细分,针对一个主机或域名的最大并发数,每路由最大连接数
    //如果是微服务下，则建议根据微服务实例的情况适当降低
    private Integer maxPerRoute ;

    ////服务器返回数据(response)的时间，超过该时间抛出read timeout
    private Integer socketTimeout;

    ////连接上服务器(握手成功)的时间，超出该时间抛出connect timeout
    private Integer connectTimeout;

    //从连接池中获取连接的超时时间，超过该时间未拿到可用连接，会抛出org.apache.http.conn.ConnectionPoolTimeoutException: Timeout waiting for connection from pool
    private Integer connectionRequestTimeout;

    //设置后台线程剔除失效连接
    private Integer maxIdleTime;

    private Integer tcpKeepLiveTime;

    //设置单个请求的重试次数
    private Integer retryTimes;

    //设置单个请求的重试固定间隔，单位毫秒
    private Integer retryIntervalTime;
}
