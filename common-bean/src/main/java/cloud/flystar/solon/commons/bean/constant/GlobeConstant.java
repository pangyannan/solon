package cloud.flystar.solon.commons.bean.constant;

import java.util.Arrays;
import java.util.List;

/**
 * 全局常量
 */
public class GlobeConstant {
   public static final String PROJECT_CODE_WEB = "web";
   public static final String RESOURCE_PREFIX = "api:web:";


   //权限相关
   public static final Long ADMIN_USERID = 0L;
   public static final String ADMIN_USERNAME = "admin";
   public static final List<String> ADMIN_SA_PERMISSION = Arrays.asList("**");
   public static final List<String> ADMIN_SA_ROLE = Arrays.asList("**");


   /**
    * 用户token session信息
    */
   public static final String TOKEN_SESSION_USER_KEY = "token_user";

   /**
    * 用户session信息
    */
   public static final String SESSION_USER_KEY = "session_user";


   //安全相关

   //用户密码错误缓存
   public static final String REDIS_USER_PASSWORD_MATCHES_FAILED_PREFIX = "user:password_matches_failed:";

   //用户图形验证码默认过期时间 10分钟
   public static final Integer captchaExpiresTimeDefault = 600;
}
