package cloud.flystar.solon.framework.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 安全相关
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "secure")
public class SecureConfig {
    private String privateKey;
    private String publicKey;

    private String adminPassword;
}