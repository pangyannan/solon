package cloud.flystar.solon.commons.httpclient;

import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.springframework.http.MediaType;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author: pangyannan
 */
@Slf4j
public class HttpClientUtil2 {
    private static HttpClientUtil2 INSTANCE;
    private  HttpClient httpClient;
    private  RequestConfig requestConfig;

    private HttpClientUtil2(HttpClient httpClient,RequestConfig requestConfig){
        super();
        this.httpClient = httpClient;
        this.requestConfig = requestConfig;
    }

    public synchronized static  HttpClientUtil2 instanceInit(HttpClient httpClient, RequestConfig requestConfig){
        if(INSTANCE != null){
            return INSTANCE;
        }
        INSTANCE = new HttpClientUtil2(httpClient, requestConfig);
        return INSTANCE;
    }

    public static RequestConfig configCopy(){
        return RequestConfig.copy(INSTANCE.requestConfig).build();
    }

    public static HttpClient httpClient(){
        return (CloseableHttpClient)INSTANCE.httpClient;
    }


    /**
     * get请求
     *
     * @param url     请求地址
     * @param headers 请求头，可以为null
     * @return String
     */
    public static String doGet(String url, Map<String, String> headers) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", url);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpGet get = new HttpGet(url);
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        get.addHeader(key, headers.get(key));
                    });
                }
                response = httpClient.execute(get);
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
                return result;
            } catch (IOException e) {
                log.error("get链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }

    /**
     * get请求 带时间配置请求
     *
     * @param url                      请求地址
     * @param headers                  请求头，可以为null
     * @param connectTimeout           连接超时时间
     * @param connectionRequestTimeout 建立连接超时时间，
     * @param socketTimeout            读取数据超时时间
     * @return String
     * @author: lll
     * @date: 2022年11月21日 17:11:21
     */
    public static String doGet(String url, Map<String, String> headers, int connectTimeout, int connectionRequestTimeout, int socketTimeout) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", url);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpGet get = new HttpGet(url);
                get.setConfig(RequestConfig.custom().setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectionRequestTimeout).setSocketTimeout(socketTimeout).build());
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        get.addHeader(key, headers.get(key));
                    });
                }
                response = httpClient.execute(get);
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
                return result;
            } catch (IOException e) {
                log.error("get链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }

    /**
     * post请求 body为json 带时间配置请求
     *
     * @param url                      请求地址
     * @param headers                  请求头，可以为null
     * @param body                     json请求体
     * @param connectTimeout           连接超时时间
     * @param connectionRequestTimeout 建立连接超时时间，
     * @param socketTimeout            读取数据超时时间
     * @return String
     * @author: lll
     * @date: 2022年11月21日 14:11:49
     */
    public static String doPost(String url, Map<String, String> headers, String body, int connectTimeout, int connectionRequestTimeout, int socketTimeout) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", body);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpPost post = new HttpPost(url);
                post.setConfig(RequestConfig.custom().setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectionRequestTimeout).setSocketTimeout(socketTimeout).build());
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        post.addHeader(key, headers.get(key));
                    });
                }
                post.addHeader(HTTP.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
                // 封装请求体
                if (StrUtil.isNotBlank(body)) {
                    // 请求体主要封装在HttpEntity中
                    post.setEntity(new StringEntity(body, Charset.forName(httpCharset)));
                }

                response = httpClient.execute(post);
                // 处理响应
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
            } catch (IOException e) {
                log.error("post链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }

    /**
     * post请求 body为json
     *
     * @param url     请求地址
     * @param headers 请求头，可以为null
     * @param body    json请求体
     * @return String
     * @author: lll
     * @date: 2022年11月21日 14:11:49
     */
    public static String doPost(String url, Map<String, String> headers, String body) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", body);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpPost post = new HttpPost(url);
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        post.addHeader(key, headers.get(key));
                    });
                }
                post.addHeader(HTTP.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
                // 封装请求体
                if (StrUtil.isNotBlank(body)) {
                    // 请求体主要封装在HttpEntity中
                    post.setEntity(new StringEntity(body, Charset.forName(httpCharset)));
                }

                response = httpClient.execute(post);
                // 处理响应
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
            } catch (IOException e) {
                log.error("post链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }

    /**
     * post请求 body为form
     *
     * post请求 body为json 带时间配置请求
     *
     * @param url                      请求地址
     * @param headers                  请求头，可以为null
     * @param body                     form请求体
     * @return String
     * @author: lll
     * @date: 2022年11月21日 14:11:49
     */
    public static String doPost(String url, Map<String, String> headers, Map body, int connectTimeout, int connectionRequestTimeout, int socketTimeout) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", body);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpPost post = new HttpPost(url);
                post.setConfig(RequestConfig.custom().setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectionRequestTimeout).setSocketTimeout(socketTimeout).build());
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        post.addHeader(key, headers.get(key));
                    });
                }
                // 封装请求体
                List<NameValuePair> nvps = new ArrayList<>();
                for (Iterator iter = body.keySet().iterator(); iter.hasNext(); ) {
                    String name = (String) iter.next();
                    String value = String.valueOf(body.get(name));
                    nvps.add(new BasicNameValuePair(name, value));
                }
                post.setEntity(new UrlEncodedFormEntity(nvps));

                response = httpClient.execute(post);
                // 处理响应
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
            } catch (IOException e) {
                log.error("post链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }

    /**
     * post请求 body为form
     *
     * post请求 body为json 带时间配置请求
     *
     * @param url                      请求地址
     * @param headers                  请求头，可以为null
     * @param body                     json请求体
     * @param connectTimeout           连接超时时间
     * @param connectionRequestTimeout 建立连接超时时间，
     * @param socketTimeout            读取数据超时时间
     * @return String
     * @author: lll
     * @date: 2022年11月21日 14:11:49
     */
    public static String doPost(String url, Map<String, String> headers, Map body) {
        String httpCharset = "utf-8";
        // 创建HttpClient对象
        CloseableHttpClient httpClient = (CloseableHttpClient)INSTANCE.httpClient;
        // 创建HttpResponse对象
        CloseableHttpResponse response = null;
        log.info("request param info : {}", body);
        log.info("request header info : {}", headers);
        try {
            try {
                // 创建HttpPost对象
                HttpPost post = new HttpPost(url);
                // 封装请求头
                if (null != headers) {
                    headers.keySet().forEach(key -> {
                        post.addHeader(key, headers.get(key));
                    });
                }
                // 封装请求体
                List<NameValuePair> nvps = new ArrayList<>();
                for (Iterator iter = body.keySet().iterator(); iter.hasNext(); ) {
                    String name = (String) iter.next();
                    String value = String.valueOf(body.get(name));
                    nvps.add(new BasicNameValuePair(name, value));
                }
                post.setEntity(new UrlEncodedFormEntity(nvps));

                response = httpClient.execute(post);
                // 处理响应
                String result = EntityUtils.toString(response.getEntity(), Charset.forName(httpCharset));
                log.info("response info : {}", result);
            } catch (IOException e) {
                log.error("post链接失败：" + e.getMessage());
            } finally {
                // 释放连接
                response.close();
            }
        } catch (IOException e) {
            log.error("post关闭response失败：" + e.getMessage());
        }
        return null;
    }
}
