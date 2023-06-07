package cloud.flystar.solon.commons.pool;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.ttl.TransmittableThreadLocal;

import java.util.HashMap;
import java.util.Map;

/**
 * 本地线程环境
 */
public class WebThreadContextUtil {
    private static final ThreadLocal<Map<String,Object>> threadLocal = new TransmittableThreadLocal<>();

    /**
     * 初始化线程环境
     */
    public static void initContext(){
        if(threadLocal.get() == null){
            Map<String, Object> map = new HashMap<>();
            threadLocal.set(map);
        }
    }


    /**
     * 初始化线程环境
     */
    public static void initContext(Map<String, Object> map){
        if(threadLocal.get() == null){
            threadLocal.set(map);
        }
    }

    public static void clearContext(){
        if(threadLocal.get() != null){
            threadLocal.get().clear();
        }
        threadLocal.remove();
    }

    public static Object get(String key){
        if(StrUtil.isBlank(key)){
          return null;
        }
        return threadLocal.get().get(key);
    }

    public static boolean containsKey(String key){
        return threadLocal.get().containsKey(key);
    }

    public static void put(String key,Object object){
      threadLocal.get().put(key,object);
    }


    public static Map<String,Object> getMap(){
        Map<String, Object> map = threadLocal.get();
        return MapUtil.unmodifiable(map);
    }
}
