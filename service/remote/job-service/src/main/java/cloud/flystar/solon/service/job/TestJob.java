package cloud.flystar.solon.service.job;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Slf4j
@Component
public class TestJob {
    private int i;

    @PostConstruct
    public void  init(){
       log.debug("Scheduled Init");
    }

    @Scheduled(cron ="0/10 * * * * ?")
    public void sayHello() {
        log.debug("Scheduled---->{}",i++);
    }
}
