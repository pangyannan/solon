package cloud.flystar.solon.user.api.dto.account;

import lombok.Data;

import java.awt.image.BufferedImage;

/**
 * 图形验证码生成结果
 */
@Data
public class CaptchaImageResourceDto {
    /**
     * 问题字符串
     */
    private String questionCode;

    /**
     * 问题图像
     */
    private BufferedImage questionCodeImage;

    /**
     * 预期的答案
     */
    private String expectCode;

    /**
     * 加密的答案
     */
    private String expectCodeEncrypt;

    /**
     * 加密后答案的TOKEN，JWT格式
     */
    private String captchaToken;
}
