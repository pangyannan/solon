package cloud.flystar.solon.framework.config.pool;

import cloud.flystar.solon.commons.pool.WebThreadContextUtil;
import org.springframework.core.task.TaskDecorator;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * 线程池环境传递
 */
public class ContextCopyingDecorator implements TaskDecorator {
    @Override
    public Runnable decorate(Runnable runnable) {
        //获取主线程中设置的线程数据
        Map<String, Object> map = Optional.ofNullable(WebThreadContextUtil.getMap()).orElse(new HashMap<>());

        //防止主线程结束后map被清空，重新设置一个Map
        Map<String, Object> newMap = new HashMap<>(map);
        return () -> {
            try {
                //设置子线程的环境变量
                WebThreadContextUtil.initContext(newMap);
                runnable.run();
            } finally {
                WebThreadContextUtil.clearContext();
            }
        };
    }
}
