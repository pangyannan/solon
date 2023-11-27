package cloud.flystar.solon.core.config.http;

import cloud.flystar.solon.commons.httpclient.DefaultHttpPoolConstants;
import cloud.flystar.solon.commons.httpclient.HttpClientConfig;
import cloud.flystar.solon.commons.httpclient.HttpClientUtil2;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Configuration
public class RestTemplateConfig {
    @Bean
    public RequestConfig requestConfig(cloud.flystar.solon.core.config.http.HttpClientConfig httpClientConfig){
        DefaultHttpPoolConstants defaultHttpPoolConstants = HttpClientConfig.getDefaultHttpPoolConstants();
        Optional.ofNullable(httpClientConfig.getPoolMaxSize()).ifPresent(defaultHttpPoolConstants::setPoolMaxSize);
        Optional.ofNullable(httpClientConfig.getMaxPerRoute()).ifPresent(defaultHttpPoolConstants::setMaxPerRoute);
        Optional.ofNullable(httpClientConfig.getSocketTimeout()).ifPresent(defaultHttpPoolConstants::setSocketTimeout);
        Optional.ofNullable(httpClientConfig.getConnectTimeout()).ifPresent(defaultHttpPoolConstants::setConnectTimeout);
        Optional.ofNullable(httpClientConfig.getConnectionRequestTimeout()).ifPresent(defaultHttpPoolConstants::setConnectionRequestTimeout);
        Optional.ofNullable(httpClientConfig.getMaxIdleTime()).ifPresent(defaultHttpPoolConstants::setMaxIdleTime);
        Optional.ofNullable(httpClientConfig.getTcpKeepLiveTime()).ifPresent(defaultHttpPoolConstants::setTcpKeepLiveTime);
        Optional.ofNullable(httpClientConfig.getRetryTimes()).ifPresent(defaultHttpPoolConstants::setRetryTimes);
        Optional.ofNullable(httpClientConfig.getRetryIntervalTime()).ifPresent(defaultHttpPoolConstants::setRetryIntervalTime);

        RequestConfig requestConfig = HttpClientConfig.buildRequestConfig(defaultHttpPoolConstants);
        return requestConfig;
    }

    @Bean
    public HttpClient httpClient(RequestConfig requestConfig){
        DefaultHttpPoolConstants defaultHttpPoolConstants = HttpClientConfig.getDefaultHttpPoolConstants();
        HttpClientConfig.setRequestConfig(requestConfig);

        HttpClient httpClient = HttpClientConfig.buildHttpClient(defaultHttpPoolConstants, requestConfig);
        HttpClientConfig.setHttpClient(httpClient);

        return httpClient;
    }
    @Bean
    public HttpClientUtil2 httpClientUtil2(RequestConfig requestConfig, HttpClient httpClient){
       return HttpClientUtil2.instanceInit(httpClient,requestConfig);
    }


    @Bean
    public ClientHttpRequestFactory clientHttpRequestFactory(HttpClient client) {
        HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory(client);
        return clientHttpRequestFactory;
    }


    /**
     * 默认的RestTemplate 使用 HttpClient 作为底层通信
     */
    @Bean(name = "httpClientRestTemplate")
    @Primary
    public RestTemplate HttpClientRestTemplate(HttpClient client, MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter){
        HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory(client);
        RestTemplate restTemplate = new RestTemplate(clientHttpRequestFactory);

        List<HttpMessageConverter<?>> messageConverters = restTemplate.getMessageConverters().stream()
                .filter(t -> !t.getClass().equals(MappingJackson2HttpMessageConverter.class))
                .collect(Collectors.toList());
        messageConverters.add(0,mappingJackson2HttpMessageConverter);
        restTemplate.setMessageConverters(messageConverters);
        return restTemplate;
    }

    /**
     * SimpleClientHttpRequestFactory
     * @return
     */
    @Bean(name = "jdkRestTemplate")
    public RestTemplate jdkRestTemplate(cloud.flystar.solon.core.config.http.HttpClientConfig httpClientConfig){
        DefaultHttpPoolConstants defaultHttpPoolConstants = HttpClientConfig.getDefaultHttpPoolConstants();

        SimpleClientHttpRequestFactory simpleClientHttpRequestFactory = new SimpleClientHttpRequestFactory();
        simpleClientHttpRequestFactory.setConnectTimeout(Optional.ofNullable(httpClientConfig.getConnectTimeout()).orElse(defaultHttpPoolConstants.getConnectTimeout()));
        simpleClientHttpRequestFactory.setReadTimeout(Optional.ofNullable(httpClientConfig.getSocketTimeout()).orElse(defaultHttpPoolConstants.getSocketTimeout()));
        return new RestTemplate(simpleClientHttpRequestFactory);
    }
}
