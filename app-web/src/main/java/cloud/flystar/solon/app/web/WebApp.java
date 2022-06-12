package cloud.flystar.solon.app.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "cloud.flystar.solon")
public class WebApp {
    public static void main(String[] args){
        SpringApplication.run(WebApp.class, args);
    }
}
