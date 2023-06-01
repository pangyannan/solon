package cloud.flystar.solon.commons.httpclient;


import lombok.SneakyThrows;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.config.ConnectionConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultConnectionKeepAliveStrategy;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.conn.ManagedHttpClientConnectionFactory;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.util.EntityUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeUnit;

public class HttpClientConfig {
    private static final DefaultHttpPoolConstants defaultHttpPoolConstants = new DefaultHttpPoolConstants();
    private static  RequestConfig REQUEST_CONFIG_INSTANCE = buildRequestConfig(defaultHttpPoolConstants);
    private static  HttpClient HTTP_CLIENT_INSTANCE  = buildHttpClient(defaultHttpPoolConstants,REQUEST_CONFIG_INSTANCE);

    public static DefaultHttpPoolConstants getDefaultHttpPoolConstants(){
        return defaultHttpPoolConstants;
    }

    public static HttpClient httpClient(){
        return HTTP_CLIENT_INSTANCE;
    }

    public static void setHttpClient(HttpClient httpClient){
        HTTP_CLIENT_INSTANCE = httpClient;
    }

    public static RequestConfig.Builder requestConfigCopy(){
        return RequestConfig.copy(REQUEST_CONFIG_INSTANCE);
    }

    public static void setRequestConfig(RequestConfig requestConfig){
        REQUEST_CONFIG_INSTANCE = requestConfig;
    }


    public static RequestConfig buildRequestConfig(DefaultHttpPoolConstants httpPoolConstants){
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(httpPoolConstants.getConnectTimeout()) //连接上服务器(握手成功)的时间，超出该时间抛出connect timeout
                .setConnectionRequestTimeout(httpPoolConstants.getConnectionRequestTimeout()) //从连接池中获取连接的超时时间
                .setSocketTimeout(httpPoolConstants.getSocketTimeout()) ///服务器返回数据(response)的时间，超过该时间抛出read timeout
                .setRedirectsEnabled(false)  //禁止自动301跳转
                .build();
        return requestConfig;
    }


    public static HttpClient buildHttpClient(DefaultHttpPoolConstants httpPoolConstants,RequestConfig requestConfig){
        Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create()
                .register("http", PlainConnectionSocketFactory.getSocketFactory())
                .register("https", SSLConnectionSocketFactory.getSocketFactory())
                .build();
        PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry, ManagedHttpClientConnectionFactory.INSTANCE, null, null, httpPoolConstants.getTcpKeepLiveTime(),TimeUnit.MILLISECONDS);

        //设置整个连接池最大连接数 根据自己的场景决定
        connectionManager.setMaxTotal(httpPoolConstants.getPoolMaxSize());
        //路由是对maxTotal的细分,针对一个url的最大并发数,每路由最大连接数，默认值是2
        connectionManager.setDefaultMaxPerRoute(httpPoolConstants.getMaxPerRoute());

        //单独设置设置到某个路由的最大连接数，会覆盖defaultMaxPerRoute
//        connectionManager.setMaxPerRoute(new HttpRoute(new HttpHost("somehost", 80)), 150);


        ConnectionConfig connectionConfig = ConnectionConfig.custom().setCharset(Charset.defaultCharset()).build();
        connectionManager.setDefaultConnectionConfig(connectionConfig);

        SocketConfig socketConfig = SocketConfig.custom().build();
        connectionManager.setDefaultSocketConfig(socketConfig);




        //默认针对所有的请求设置超时时间,也可以放到后面针对某一个url设置这些个超时时间
        HttpClientBuilder httpClientBuilder = HttpClientBuilder.create()
                .setDefaultRequestConfig(requestConfig == null ? buildRequestConfig(httpPoolConstants) : requestConfig)
                .setConnectionManager(connectionManager)
                // 设置超时时间,超时后线程被回收
                .evictExpiredConnections()
                .evictIdleConnections(httpPoolConstants.getMaxIdleTime(),TimeUnit.MILLISECONDS);

        //重试配置
        if(httpPoolConstants.getRetryTimes()<=0){
            //关闭自动重试
            httpClientBuilder.disableAutomaticRetries();
        }else{
            //开启自动重试
            httpClientBuilder.setRetryHandler(new DefaultHttpRequestRetryHandler(httpPoolConstants.getRetryTimes(), true));

        }
        //长链接配置
        httpClientBuilder.setKeepAliveStrategy(DefaultConnectionKeepAliveStrategy.INSTANCE);

        return httpClientBuilder.build();
    }

    public  static ClientHttpRequestFactory clientHttpRequestFactory() {
        HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory(httpClient());
        return clientHttpRequestFactory;
    }

    @SneakyThrows
    public static void main(String[] args) {
        CloseableHttpClient httpClient = (CloseableHttpClient) httpClient();
        HttpGet httpGet = new HttpGet("https://wwww.taobao.com");

        for (int i = 0; i < 100; i++) {
            CloseableHttpResponse response = httpClient.execute(httpGet);
            System.out.println(EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8).length());
        }

//
//        HttpPost httpPost = new HttpPost("https://wwww.baidu.com");
//        HttpEntity httpEntity = new StringEntity("", StandardCharsets.UTF_8);
//        httpPost.setEntity(httpEntity);
//
//        HttpResponse postResponse = httpClient.execute(httpPost);
//        System.out.println(postResponse);//

        RestTemplate restTemplate = new RestTemplate(clientHttpRequestFactory());
        ResponseEntity<String> forEntity = restTemplate.getForEntity("http://wwww.taobao.com", String.class);


    }
}
