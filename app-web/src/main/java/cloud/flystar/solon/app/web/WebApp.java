package cloud.flystar.solon.app.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication(scanBasePackages = "cloud.flystar.solon")
@EnableConfigurationProperties
@EnableScheduling
public class WebApp {
    public static void main(String[] args){
        SpringApplication.run(WebApp.class, args);
    }
}
