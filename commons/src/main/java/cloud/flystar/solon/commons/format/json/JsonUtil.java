package cloud.flystar.solon.commons.format.json;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import org.springframework.util.StringUtils;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @作者: 庞衍楠
 * @日期: 2021-10-27
 * @描述:
 */
public class JsonUtil {

    private static  ObjectMapper mapper = ObjectMapperFactory.INSTANCE();

    /**
     * 复制ObjectMapper，用于自定义场景，不影响全局配置
     * @return
     */
    public static ObjectMapper getCopyMapper(){
        return mapper.copy();
    }

    /**
     * 转换对象为字符串
     */
    @SneakyThrows
    public static String json(Object obj){
        return mapper.writeValueAsString(obj);
    }

    /**
     * 转换对象为格式化字符串
     */
    @SneakyThrows
    public static  String jsonPretty(Object obj) {
        return mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);
    }

    /**
     * 转换对象为二进制
     * @param obj
     * @return
     */
    @SneakyThrows
    public static byte[] jsonByte(Object obj){
        return mapper.writeValueAsBytes(obj);
    }

    /**
     * 字符串转对象
     * 如果待转换对象为容器或者泛型的，使用TypeReference
     */
    @SneakyThrows
    public static <T>  T jsonToBean(String json, Class<T> clazz){
        return mapper.readValue(json,clazz);
    }
    /**
     * 将json转化为对应的实体对象
     *  new TypeReference<Message<Chat>>() {}
     *  new TypeReference<List<User>>() {}
     *  new TypeReference<Map<String,User>>() {}
     *  new TypeReference<RestJson<List<MopNode>>>(){}
     *  new TypeReference<List<RestJson<List<MopNode>>>>(){}
     *  另外 objectMapper.getTypeFactory().constructParametricType(List.class, clazz)方法夜比较有意思，可以通过class构造Type类型
     */
    @SneakyThrows
    public static <T>  T jsonToBean(String json, TypeReference<T> type){
        return mapper.readValue(json,type);
    }

    /**
     * 二进制转对象
     */
    public static <T>  T byteToBean(byte[] bytes, Class<T> clazz){
        return jsonToBean(new String(bytes, StandardCharsets.UTF_8),clazz);
    }


    @SneakyThrows
    public static <T> List<T> jsonToArray(String json, Class<T> clazz){
        if (!StringUtils.hasText(json) || clazz == null){
            return new ArrayList<>(0);
        }
        JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, clazz);
        return mapper.readValue(json,javaType);
    }

    @SneakyThrows
    public static <K,V> Map<K,V> jsonMap(String json, Class<K> kClazz, Class<V> vClazz){
        if (!StringUtils.hasText(json) || kClazz == null || vClazz == null){
            return new HashMap<>(0);
        }
        JavaType javaType = mapper.getTypeFactory().constructMapType(HashMap.class, kClazz, vClazz);
        return mapper.readValue(json,javaType);
    }
}
