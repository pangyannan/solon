package cloud.flystar.solon.commons.pool;

import com.google.common.util.concurrent.ThreadFactoryBuilder;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * 线程池统一管理，在其他模块非有特殊必要，不要建立线程池，使用线程池工具统一引用，方便管理
 * @author pangyannan
 */
@Slf4j
public class ThreadPoolUtil {
    /**
     * 定时任务线程池
     */
    private static final String SCHEDULED_POOL_NAME = "common-scheduled";
    private static final ScheduledExecutorService scheduledExecutor = Executors.newScheduledThreadPool(Runtime.getRuntime().availableProcessors() * 2, new ThreadFactoryBuilder().setNameFormat(SCHEDULED_POOL_NAME+"-%d").build());

    //添加关闭线程池的钩子
    static {
        Runtime.getRuntime().addShutdownHook(new Thread(() -> shutdown(SCHEDULED_POOL_NAME,scheduledExecutor)));
    }

    private ThreadPoolUtil(){throw new IllegalStateException("Utility class");}
    /**
     * 定时任务线程池
     * @return ScheduledExecutorService
     */
    public static  ScheduledExecutorService scheduledExecutor(){
        return scheduledExecutor;
    }

    // 关闭线程池的钩子函数
    private static void shutdown(String poolName,ExecutorService executorService) {
        log.info("关闭线程池[{}]",poolName);
        // 第一步：使新任务无法提交
        executorService.shutdown();
        try {
            // 第二步：等待未完成任务结束
            if(!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                // 第三步：取消当前执行的任务
                log.warn("立刻关闭线程池[{}]",poolName);
                executorService.shutdownNow();
                // 第四步：等待任务取消的响应
                if(!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                    log.error("线程池未能中断[{}]",poolName);
                }
            }
        } catch(InterruptedException ie) {
            // 第五步：出现异常后，重新取消当前执行的任务
            executorService.shutdownNow();
            Thread.currentThread().interrupt(); // 设置本线程中断状态
        }
    }


}
