package cloud.flystar.solon.dictionary.service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@SpringBootApplication(scanBasePackages = "cloud.flystar.solon")
@EnableConfigurationProperties
public class JunitApp {
    public static void main(String[] args){
        SpringApplication.run(JunitApp.class, args);
    }
}
