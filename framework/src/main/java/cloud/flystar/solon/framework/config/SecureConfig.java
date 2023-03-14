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
    /**
     * 安全加密私钥
     */
    private String privateKey;
    /**
     * 安全加密公钥
     */
    private String publicKey;

    /**
     * 超级管理员admin密码
     */
    private String adminPassword;

    /**
     * 是否开启图形验证码
     */
    private Boolean captchaOpen;

    /**
     * 图形验证码过期时间，单位秒
     */
    private Integer captchaExpiresTime;

    /**
     * JWT密钥
     */
    private String jwtKey;
}