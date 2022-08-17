package cloud.flystar.solon.commons.crypto;

import cloud.flystar.solon.commons.crypto.bcrypt.BCryptPasswordEncoder;
import cloud.flystar.solon.commons.crypto.password.DelegatingPasswordEncoder;

import java.util.HashMap;
import java.util.Map;

/**
 * 密码验证集合器
 */
public final class PasswordEncoderFactories {

    private PasswordEncoderFactories() {
    }

    public static PasswordEncoder createDelegatingPasswordEncoder() {
        String encodingId = "bcrypt";
        Map<String, PasswordEncoder> encoders = new HashMap<>();
        encoders.put(encodingId, new BCryptPasswordEncoder(10));
//        encoders.put("ldap", new org.springframework.security.crypto.password.LdapShaPasswordEncoder());
//        encoders.put("MD4", new org.springframework.security.crypto.password.Md4PasswordEncoder());
//        encoders.put("MD5", new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("MD5"));
//        encoders.put("noop", org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance());
//        encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
//        encoders.put("scrypt", new SCryptPasswordEncoder());
//        encoders.put("SHA-1", new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("SHA-1"));
//        encoders.put("SHA-256",
//                new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("SHA-256"));
//        encoders.put("sha256", new org.springframework.security.crypto.password.StandardPasswordEncoder());
//        encoders.put("argon2", new Argon2PasswordEncoder());
        return new DelegatingPasswordEncoder(encodingId, encoders);
    }

}
