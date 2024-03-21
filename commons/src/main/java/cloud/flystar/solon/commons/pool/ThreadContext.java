package cloud.flystar.solon.commons.pool;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.ttl.TransmittableThreadLocal;

import java.util.HashMap;
import java.util.Map;

/**
 * 本地线程环境
 */
public class ThreadContext {
    private static final ThreadLocal<Map<String,Object>> threadLocal = new TransmittableThreadLocal<>();

    /**
     * 初始化线程环境
     */
    public static void initContext(){
        Map<String, Object> map = threadLocal.get();
        if(map == null){
            map = new HashMap<>();
            threadLocal.set(map);
        }
    }


    /**
     * 初始化线程环境
     */
    public static void initContext(Map<String, Object> map){
        if(map == null){
            map = new HashMap<>();
        }
        threadLocal.set(map);
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
        Map<String, Object> map = threadLocal.get();
        if(map == null){
            return null;
        }
        return map.get(key);
    }

    public static boolean containsKey(String key){
        Map<String, Object> map = threadLocal.get();
        if(map == null){
            return false;
        }
        return map.containsKey(key);
    }

    public static void put(String key,Object object){
        Map<String, Object> map = threadLocal.get();
        if(map == null){
            initContext();
            map = threadLocal.get();
        }
        map.put(key,object);
    }

    public static void remove(String... keys){
        if(keys == null){
            return;
        }
        Map<String, Object> map = threadLocal.get();
        if(map == null){
          return;
        }
        for (String key : keys) {
            map.remove(key);
        }
    }


    public static Map<String,Object> getUnmodifiableMap(){
        Map<String, Object> map = threadLocal.get();
        if(map == null){
            return MapUtil.empty();
        }
        return MapUtil.unmodifiable(map);
    }
}
