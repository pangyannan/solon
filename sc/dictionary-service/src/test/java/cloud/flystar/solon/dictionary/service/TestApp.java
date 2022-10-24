package cloud.flystar.solon.dictionary.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication(scanBasePackages = "cloud.flystar.solon")
@EnableConfigurationProperties
public class TestApp {
    public static void main(String[] args){
        SpringApplication.run(TestApp.class, args);
    }
}
