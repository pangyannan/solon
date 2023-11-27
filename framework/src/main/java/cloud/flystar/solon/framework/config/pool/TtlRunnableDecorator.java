package cloud.flystar.solon.framework.config.pool;

import cloud.flystar.solon.commons.pool.WebThreadContextUtil;
import com.alibaba.ttl.TtlRunnable;
import org.slf4j.MDC;
import org.springframework.core.task.TaskDecorator;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.Map;

/**
 * 线程池环境传递，借助阿里云的TtlRunnable实现
 * 注意，该方式回要求线程变量为 TransmittableThreadLocal
 * 如不不是TransmittableThreadLocal，则需要手动添加变量，参考 ContextCopyingDecorator
 */
public class TtlRunnableDecorator implements TaskDecorator {
    @Override
    public Runnable decorate(Runnable runnable) {
        //不是TransmittableThreadLocal包装的线程变量

        Map<String, Object> threadContextMap = WebThreadContextUtil.getUnmodifiableMap();
        //MDC
        Map<String, String> mdcMap = MDC.getCopyOfContextMap();
        // 获取主线程中的请求信息（我们的用户信息也放在里面）
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();

        //使用TtlRunnable包装原始Runnable
        return TtlRunnable.get(() -> {
            try {
                if(threadContextMap != null && threadContextMap.size() > 0){
                    WebThreadContextUtil.initContext(threadContextMap);
                }
                if(mdcMap !=null && mdcMap.size() > 0){
                    MDC.setContextMap(mdcMap);
                }
                if(requestAttributes != null ){
                    RequestContextHolder.setRequestAttributes(requestAttributes);
                }
                runnable.run();
            } finally {
                WebThreadContextUtil.clearContext();
                RequestContextHolder.resetRequestAttributes();
                MDC.clear();
            }
        });
    }
}
