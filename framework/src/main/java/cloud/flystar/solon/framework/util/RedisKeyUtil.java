package cloud.flystar.solon.framework.util;

import cn.hutool.core.lang.Assert;
import cn.hutool.extra.spring.SpringUtil;
import org.apache.commons.lang3.StringUtils;

import java.util.StringJoiner;

/**
 *
 */
public class RedisKeyUtil {
    /**
     * redisKey的默认分隔符
     */
    public static final String redisKeyJoinChar=":";
    public static final String namespacePropertyKey ="redis.key.namespace";

    /**
     * 真个应用的命名空间，一般时应用名称
     */
    public static String namespace = StringUtils.EMPTY;

    public static String getNamespace(){
        if(StringUtils.isEmpty(namespace)){
            namespace = SpringUtil.getProperty(namespacePropertyKey);
        }
        if(StringUtils.isEmpty(namespace)){
            namespace =  SpringUtil.getApplicationName();
        }

        return namespace;
    }

    /**
     * key 拼接，自动拼接命名空间在最前面
     * @param keys
     * @return
     */
    public static String nameSpaceJoinKey(String... keys){
        Assert.isTrue(keys != null && keys.length > 0 ,"redis key输入错误");
        StringJoiner joiner = new StringJoiner(redisKeyJoinChar);
        joiner.add(getNamespace());
        for (CharSequence cs: keys) {
            joiner.add(cs);
        }
        return joiner.toString();
    }


    /**
     * key 拼接，自动拼接命名空间在最前面
     * @param keys
     * @return
     */
    public static String joinKey(String... keys){
        Assert.isTrue(keys != null && keys.length > 0 ,"redis key输入错误");
        StringJoiner joiner = new StringJoiner(redisKeyJoinChar);
        for (CharSequence cs: keys) {
            joiner.add(cs);
        }
        return joiner.toString();
    }
}
