package cloud.flystar.solon.commons.httpclient;

import cloud.flystar.solon.commons.format.json.ObjectMapperFactory;
import cn.hutool.core.util.NumberUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.web.util.UriUtils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * httpClient工具, 仅实现了GET和POST
 * @author: pangyannan
 */
@Slf4j
public class HttpClientUtil {
    public static final String HTTP_METHOD_GET = "GET";
    public static final String HTTP_METHOD_POST = "POST";

    private static final ObjectMapper objectMapper = ObjectMapperFactory.INSTANCE();
    private static final Charset CHARSET_UTF8 = Charset.forName("UTF-8");
    private static final CloseableHttpClient httpClient = (CloseableHttpClient)HttpClientConfig.httpClient();
    private static  List<Header> defaultHeaders = new ArrayList<>();
    static {
        String osname = System.getProperty("os.name");
        defaultHeaders.add(new BasicHeader("Accept", "*/*"));
        defaultHeaders.add(new BasicHeader("User-Agent", "Mozilla/5.0 (" + osname + "; VFramework/1.0.0; HttpClient/4.5)"));
        defaultHeaders.add(new BasicHeader("Accept-Language", "zh-CN,zh;q=0.8"));
        defaultHeaders.add(new BasicHeader("Cache-Control", "max-age=0"));
        defaultHeaders.add(new BasicHeader("Connection", "keep-alive"));
        defaultHeaders.add(new BasicHeader("Accept-Encoding", "gzip,deflate"));
    }


    public static <T> T sendData(String url, String httpMethod, HttpContentTypeEnum contentType, Object parameter, Map<String, String> headers, int timeout,
                                 TypeReference<T> typeReference) {
        return sendData(url, httpMethod, contentType, parameter, headers, timeout, typeReference, true);
    }

    public static <T> T sendGet(String url, Object parameter, Map<String, String> headers, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_GET, null, parameter, headers, null, typeReference, true);
    }

    public static String sendGet(String url, Object parameter, Map<String, String> headers) {
        return sendData(url, HTTP_METHOD_GET, null, parameter, headers, null, new TypeReference<String>() {
        }, true);
    }

    public static String sendGet(String url, Object parameter) {
        return sendData(url, HTTP_METHOD_GET, null, parameter, null, null, new TypeReference<String>() {
        }, true);
    }

    public static <T> T sendGet(String url, Object parameter, Map<String, String> headers, int timeout, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_GET, null, parameter, headers, timeout, typeReference, true);
    }

    /**
     * 按urlencoding方式提交
     */
    public static <T> T sendPostForm(String url, Object parameter, Map<String, String> headers, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.URL_ENCODING, parameter, headers, null, typeReference, true);
    }

    public static String sendPostForm(String url, Object parameter, Map<String, String> headers) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.URL_ENCODING, parameter, headers, null, new TypeReference<String>() {
        }, true);
    }

    public static String sendPostForm(String url, Object parameter) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.URL_ENCODING, parameter, null, null, new TypeReference<String>() {
        }, true);
    }

    public static <T> T sendPostForm(String url, Object parameter, Map<String, String> headers, int timeout, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.URL_ENCODING, parameter, headers, timeout, typeReference, true);
    }

    /**
     * 按json方式提交
     */
    public static <T> T sendPostJson(String url, Object parameter, Map<String, String> headers, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.JSON, parameter, headers, null, typeReference, true);
    }

    public static String sendPostJson(String url, Object parameter, Map<String, String> headers) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.JSON, parameter, headers, null, new TypeReference<String>() {
        }, true);
    }

    public static String sendPostJson(String url, Object parameter) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.JSON, parameter, null, null, new TypeReference<String>() {
        }, true);
    }

    public static <T> T sendPostJson(String url, Object parameter, Map<String, String> headers, int timeout, TypeReference<T> typeReference) {
        return sendData(url, HTTP_METHOD_POST, HttpContentTypeEnum.JSON, parameter, headers, timeout, typeReference, true);
    }

    @SuppressWarnings("unchecked")
    public static <T> T sendData(String url, String httpMethod, HttpContentTypeEnum contentType, Object parameter, Map<String, String> headers, Integer timeout,
                                 TypeReference<T> typeReference, boolean encodeQuery) {
        boolean success = false;
        long st = System.currentTimeMillis();
        String host = null;

        CloseableHttpResponse response = null;
        try {

            StringBuilder uri = new StringBuilder();
            uri.append(url);
            HttpRequestBase request;
            if (httpMethod.equals(HTTP_METHOD_GET)) {
                if (parameter != null) {
                    // Http Parameters
                    Object o = parameter;
                    Map<?, ?> m = convertToMap(o);
                    boolean first = true;
                    for (Map.Entry<?, ?> e : m.entrySet()) {
                        Object k = e.getKey();
                        Object v = e.getValue();
                        if (k != null && v != null) {
                            if (first) {
                                uri.append("?");
                            } else {
                                uri.append("&");
                            }
                            uri.append(k.toString()).append("=").append(v.toString());
                            first = false;
                        }
                    }

                }
                if (encodeQuery) {
                    request = new HttpGet(UriUtils.encodeQuery(uri.toString(), CHARSET_UTF8));
                } else {
                    request = new HttpGet(uri.toString());
                }
            } else if (httpMethod.equals(HTTP_METHOD_POST)) {
                HttpPost post;
                if (encodeQuery) {
                    post = new HttpPost(UriUtils.encodeQuery(uri.toString(), CHARSET_UTF8));
                } else {
                    post = new HttpPost(uri.toString());
                }

                request = post;

                if (contentType == HttpContentTypeEnum.URL_ENCODING) {
                    if (parameter != null) {
                        // Http Parameters
                        List<NameValuePair> parameters = new ArrayList<>();
                        Object o = parameter;
                        Map<?, ?> m = convertToMap(o);
                        for (Map.Entry<?, ?> e : m.entrySet()) {
                            Object k = e.getKey();
                            Object v = e.getValue();
                            if (k != null && v != null) {
                                parameters.add(new BasicNameValuePair(k.toString(), v.toString()));
                            }
                        }
                        post.setEntity(new UrlEncodedFormEntity(parameters, CHARSET_UTF8));
                    }

                } else {
                    byte[] bytes = null;
                    if (contentType == HttpContentTypeEnum.JSON) {
                        if (parameter instanceof String) {
                            bytes = ((String) parameter).getBytes(CHARSET_UTF8);
                        } else if (parameter != null) {
                            bytes = objectMapper.writeValueAsBytes(parameter);
                            //LOGGER.debug("data:{}",new String(bytes));
                        }
                        request.setHeader(HttpHeaders.CONTENT_TYPE, contentType.getContentType());
                    } else {
                        if (parameter instanceof String) {
                            bytes = ((String) parameter).getBytes(CHARSET_UTF8);
                        } else {
                            bytes = objectMapper.writeValueAsBytes(parameter);
                        }
                    }
                    if (bytes != null) {
                        ByteArrayEntity entity = new ByteArrayEntity(bytes);
                        post.setEntity(entity);
                    }
                }

            } else {
                throw new IllegalArgumentException("Http method not supported: " + httpMethod);
            }


            // 设置请求超时时间
            if(timeout != null && timeout >=0){
                RequestConfig.Builder builder = HttpClientConfig.requestConfigCopy()
                        .setSocketTimeout(timeout)
                        .setConnectTimeout(timeout)
                        .setConnectionRequestTimeout(timeout);
                request.setConfig(builder.build());
            }

            defaultHeaders.forEach(request::setHeader);
            if (headers != null) {
                // Http Headers
                setHeaders(request, headers);
            }


            host = request.getURI().getHost();
            log.debug("Start to invoke url:{}", uri.toString());
            response = httpClient.execute(request);
            int status = response.getStatusLine().getStatusCode();
            if (status == 200 || status == 201) {
                success = true;
                boolean readEntity = true;
                Header header = response.getFirstHeader("Content-Length");
                if (header != null) {
                    long contentLength = NumberUtil.parseLong(header.getValue());
                    if (contentLength == 0) {
                        readEntity = false;
                    }
                }
                HttpEntity entity = response.getEntity();
                if (entity != null && readEntity) {
                    T result = null;
                    if (typeReference.getType() == String.class) {
                        String resultString = EntityUtils.toString(entity, CHARSET_UTF8);
                        log.debug("response: {}", resultString);
                        result = (T) resultString;
                    } else {
                        result = objectMapper.readValue(EntityUtils.toString(entity, CHARSET_UTF8), typeReference);
                    }
                    return result;
                } else {
                    return null;
                }
            } else if (status == 204) {
                return null;
            } else {
                throw new RuntimeException("Invoke Remote Server:" + url + " Failed, Status Code:" + status);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            long et = System.currentTimeMillis();
            long time = et - st;
            log.debug("host:{}, method:{}, success:{}, time:{}", host, httpMethod, success, time);
//            IoUtil.close(response);
        }
    }

    private static void setHeaders(HttpRequestBase request, Map<String, String> headers) {
        if (headers != null) {
            for (Map.Entry<?, ?> e : headers.entrySet()) {
                Object k = e.getKey();
                Object v = e.getValue();
                if (k != null && v != null) {
                    request.setHeader(k.toString(), v.toString());
                }
            }
        }
    }

    /**
     * 将参数对象转换成Map
     */
    private static Map<?, ?> convertToMap(Object o) throws Exception {
        if (o instanceof Map) {
            return (Map<?, ?>) o;
        }
        if (o instanceof List) {
            throw new IllegalArgumentException("Object cannot instanceof list,Class:" + o.getClass().getName());
        }
        Map<String, String> map = new HashMap<String, String>();
        BeanInfo beanInfo = Introspector.getBeanInfo(o.getClass());
        PropertyDescriptor[] proDescrtptors = beanInfo.getPropertyDescriptors();
        if (proDescrtptors != null && proDescrtptors.length > 0) {
            for (PropertyDescriptor propDesc : proDescrtptors) {
                Method readMethod = propDesc.getReadMethod();
                Method writeMethod = propDesc.getWriteMethod();
                if (readMethod != null && writeMethod != null) {
                    String propertyName = propDesc.getName();
                    Object p = readMethod.invoke(o);
                    if (p != null) {
                        map.put(propertyName, p.toString());
                    }
                }
            }
        }
        return map;
    }


    public static void main(String[] args) {
        String s = HttpClientUtil.sendGet("https://www.taobao.com", null);
//        System.out.println(s);
    }

}
