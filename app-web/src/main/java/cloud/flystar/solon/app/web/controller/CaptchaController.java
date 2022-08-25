package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.excetion.ErrorCodeEnum;
import cloud.flystar.solon.framework.config.SecureConfig;
import cn.dev33.satoken.config.SaCookieConfig;
import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.context.model.SaCookie;
import cn.dev33.satoken.stp.StpLogic;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.codec.Base64;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.SignUtil;
import cn.hutool.crypto.symmetric.SymmetricAlgorithm;
import cn.hutool.crypto.symmetric.SymmetricCrypto;
import cn.hutool.jwt.JWT;
import cn.hutool.jwt.JWTUtil;
import cn.hutool.jwt.JWTValidator;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import lombok.Data;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.crypto.SecretKey;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * TODO
 *
 * @author: pangyannan
 */
@RestController
@RequestMapping("/captcha")
public class CaptchaController {

    @Resource(name = "charProducer")
    private Producer charProducer;

    @Resource(name = "mathProducer")
    private Producer mathProducer;

    @Resource
    private SecureConfig secureConfig;


    private SymmetricCrypto symmetricCrypto;

    /**
     *  初始化AES算法
     *  byte[] key = SecureUtil.generateKey(SymmetricAlgorithm.AES.getValue()).getEncoded();
     *  String encode = Base64.encode(key);
     *  secureConfig.getCaptchaAes() 中的密钥可以这么生成
     */
    @PostConstruct
    public void init(){
        String captchaAes = secureConfig.getCaptchaAes();
        byte[] key = Base64.decode(captchaAes);
        symmetricCrypto  = new SymmetricCrypto(SymmetricAlgorithm.AES, key);


    }

    /**
     * 验证码生成
     */
    @GetMapping(value = "/image")
    public void image(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = Optional.ofNullable(request.getParameter("type")).orElse("math");

        String code ;
        BufferedImage image;
        if(StrUtil.equals(type,"math")){
            String capText = mathProducer.createText();
            String imageStr = capText.substring(0, capText.lastIndexOf("@"));
            code = capText.substring(capText.lastIndexOf("@") + 1);
            image =  mathProducer.createImage(imageStr);
        }else {
            code = charProducer.createText();
            image = charProducer.createImage(code);
        }

        //设置头，输出格式与不缓存
        response.setDateHeader("Expires", 0);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        response.setHeader("Pragma", "no-cache");
        response.setContentType("image/jpeg");



        //验证码结果加密
        String codeEncrypt = symmetricCrypto.encryptBase64(code);

        //验证码放入JWT中
        Map<String,String> map = new HashMap<>();
        map.put("codeEncrypt",codeEncrypt);
        String captchaToken = JWT.create()
                .addHeaders(null)
                .addPayloads(map)
                .setExpiresAt(DateUtil.offsetMinute(DateUtil.date(),1))
                .setKey(secureConfig.getCaptchaAes().getBytes(StandardCharsets.UTF_8))
                .sign();


        response.setHeader("captchaToken",captchaToken);


        StpLogic stpLogic = StpUtil.stpLogic;
        SaCookieConfig cfg = stpLogic.getConfig().getCookie();
        SaCookie cookie = new SaCookie()
                .setName("captchaToken")
                .setValue(captchaToken)
                .setMaxAge(-1)
                .setDomain(cfg.getDomain())
                .setPath(cfg.getPath())
                .setSecure(cfg.getSecure())
                .setHttpOnly(cfg.getHttpOnly())
                .setSameSite(cfg.getSameSite())
                ;
        SaHolder.getResponse().addCookie(cookie);


        ServletOutputStream outputStream = response.getOutputStream();
        //使用ImageIO向前端输出图片
        ImageIO.write(image,"jpeg",outputStream);
    }


    @PostMapping(value = "/check")
    public Result<String> check(@RequestBody CheckCodeEncrypt checkCodeEncrypt){
        //JWT验证与解析
        JWT jwt = new JWT();
        jwt.setKey(secureConfig.getCaptchaAes().getBytes(StandardCharsets.UTF_8));
        jwt.parse(checkCodeEncrypt.getCaptchaToken());

        try {
            JWTValidator.of(jwt).validateDate(DateUtil.date(), 0);
        }catch (Exception e){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0244);
        }

        if(!jwt.verify()){
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0240);
        }

        //解密结果
        String codeEncrypt = (String)jwt.getPayload("codeEncrypt");
        String decryptStr = symmetricCrypto.decryptStr(codeEncrypt);

        //对比用户输入的结果
        if(StrUtil.equals(decryptStr,checkCodeEncrypt.getCode())){
            return Result.successBuild();
        }else {
            return Result.failedBuild(ErrorCodeEnum.USER_ERROR_A0130);
        }
    }

    @Data
    public static class CheckCodeEncrypt{
        private String captchaToken;
        private String code;
    }


    public static void main(String[] args) {
        byte[] key = SecureUtil.generateKey(SymmetricAlgorithm.AES.getValue()).getEncoded();
        String captchaAes = Base64.encode(key);
        System.out.println(captchaAes);
    }
}
