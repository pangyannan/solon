package cloud.flystar.solon.framework.config.pool;

import cn.hutool.extra.spring.SpringUtil;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Component;

/**
 * 通用线程线程池配置
 */
public class ThreadPoolHolder {
   private static  ThreadPoolTaskExecutor cpuExecutor;
   private static  ThreadPoolTaskExecutor ioExecutor;
   private static ThreadPoolTaskScheduler schedulerExecutor;

   public static ThreadPoolTaskExecutor cpuExecutor(){
       if(cpuExecutor == null){
           cpuExecutor = SpringUtil.getBean(ThreadPoolConfig.cpuExecutorName,ThreadPoolTaskExecutor.class);
       }
       return cpuExecutor;
   }


    public static ThreadPoolTaskExecutor ioExecutor(){
        if(ioExecutor == null){
            ioExecutor = SpringUtil.getBean(ThreadPoolConfig.ioExecutorName,ThreadPoolTaskExecutor.class);
        }
        return ioExecutor;
    }


    public static ThreadPoolTaskScheduler schedulerExecutor(){
        if(schedulerExecutor == null){
            schedulerExecutor = SpringUtil.getBean(ThreadPoolConfig.schedulerExecutor,ThreadPoolTaskScheduler.class);
        }
        return schedulerExecutor;
    }
}
