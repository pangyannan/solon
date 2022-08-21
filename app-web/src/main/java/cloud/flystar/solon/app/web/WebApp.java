package cloud.flystar.solon.app.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication(scanBasePackages = "cloud.flystar.solon")
@EnableConfigurationProperties
public class WebApp {
    public static void main(String[] args){
        SpringApplication.run(WebApp.class, args);
    }
}
