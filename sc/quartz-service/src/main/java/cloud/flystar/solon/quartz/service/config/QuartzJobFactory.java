package cloud.flystar.solon.quartz.service.config;

import lombok.NonNull;
import org.quartz.Job;
import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.scheduling.quartz.AdaptableJobFactory;
import org.springframework.stereotype.Component;

/**
 * 为JobFactory注入SpringBean,否则Job无法使用Spring创建的bean
 */
@Component
public class QuartzJobFactory extends AdaptableJobFactory implements ApplicationContextAware {

        @Autowired
        private AutowireCapableBeanFactory capableBeanFactory;

        @Override
        @NonNull
        protected Object createJobInstance(@NonNull TriggerFiredBundle bundle) throws Exception {
            //优先从Spring中获取bean
            Class<? extends Job> jobClass = bundle.getJobDetail().getJobClass();
            Job bean = capableBeanFactory.getBean(jobClass);
            if(bean != null){
               return bean;
            }

            // 调用父类的方法
            Object jobInstance = super.createJobInstance(bundle);
            // 进行注入
            capableBeanFactory.autowireBean(jobInstance);
            return jobInstance;

        }

        @Override
        public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
            capableBeanFactory = applicationContext.getAutowireCapableBeanFactory();
        }
}
