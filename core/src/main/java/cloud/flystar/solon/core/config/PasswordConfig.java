package cloud.flystar.solon.core.config;

import cloud.flystar.solon.commons.crypto.PasswordEncoder;
import cloud.flystar.solon.commons.crypto.PasswordEncoderFactories;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 密码相关配置
 */
@Configuration
public class PasswordConfig {
    @Bean
    public PasswordEncoder passwordEncoder(){
       return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}
