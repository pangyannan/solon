package cloud.flystar.solon.commons.bean.constant;

import java.util.Arrays;
import java.util.List;

/**
 * 全局常量
 */
public class GlobeConstant {
   public static final String PROJECT_CODE_WEB = "web";



   public static final String RESOURCE_PREFIX = "api:web:";


   public static final String ADMIN_USERNAME = "admin";
   public static final List<String> ADMIN_SA_PERMISSION = Arrays.asList("**");

   /**
    * 用户密码错误缓存
    */
   public static final String REDIS_USER_PASSWORD_MATCHES_FAILED_PREFIX = "user:password_matches_failed:";
}
