package cloud.flystar.solon.commons.crypto.password;

import cloud.flystar.solon.commons.crypto.PasswordEncoder;

import java.util.HashMap;
import java.util.Map;

/**
 * TODO
 *
 * @author: pangyannan
 */
public class DelegatingPasswordEncoder  implements PasswordEncoder {

    private static final String PREFIX = "{";

    private static final String SUFFIX = "}";

    private final String idForEncode;

    private final PasswordEncoder passwordEncoderForEncode;

    private final Map<String, PasswordEncoder> idToPasswordEncoder;

    private PasswordEncoder defaultPasswordEncoderForMatches = new UnmappedIdPasswordEncoder();

    /**
     * Creates a new instance
     * @param idForEncode the id used to lookup which {@link PasswordEncoder} should be
     * used for {@link #encode(CharSequence)}
     * @param idToPasswordEncoder a Map of id to {@link PasswordEncoder} used to determine
     * which {@link PasswordEncoder} should be used for
     * {@link #matches(CharSequence, String)}
     */
    public DelegatingPasswordEncoder(String idForEncode, Map<String, PasswordEncoder> idToPasswordEncoder) {
        if (idForEncode == null) {
            throw new IllegalArgumentException("idForEncode cannot be null");
        }
        if (!idToPasswordEncoder.containsKey(idForEncode)) {
            throw new IllegalArgumentException(
                    "idForEncode " + idForEncode + "is not found in idToPasswordEncoder " + idToPasswordEncoder);
        }
        for (String id : idToPasswordEncoder.keySet()) {
            if (id == null) {
                continue;
            }
            if (id.contains(PREFIX)) {
                throw new IllegalArgumentException("id " + id + " cannot contain " + PREFIX);
            }
            if (id.contains(SUFFIX)) {
                throw new IllegalArgumentException("id " + id + " cannot contain " + SUFFIX);
            }
        }
        this.idForEncode = idForEncode;
        this.passwordEncoderForEncode = idToPasswordEncoder.get(idForEncode);
        this.idToPasswordEncoder = new HashMap<>(idToPasswordEncoder);
    }

    /**
     * Sets the {@link PasswordEncoder} to delegate to for
     * {@link #matches(CharSequence, String)} if the id is not mapped to a
     * {@link PasswordEncoder}.
     *
     * <p>
     * The encodedPassword provided will be the full password passed in including the
     * {"id"} portion.* For example, if the password of "{notmapped}foobar" was used, the
     * "id" would be "notmapped" and the encodedPassword passed into the
     * {@link PasswordEncoder} would be "{notmapped}foobar".
     * </p>
     * @param defaultPasswordEncoderForMatches the encoder to use. The default is to throw
     * an {@link IllegalArgumentException}
     */
    public void setDefaultPasswordEncoderForMatches(PasswordEncoder defaultPasswordEncoderForMatches) {
        if (defaultPasswordEncoderForMatches == null) {
            throw new IllegalArgumentException("defaultPasswordEncoderForMatches cannot be null");
        }
        this.defaultPasswordEncoderForMatches = defaultPasswordEncoderForMatches;
    }

    @Override
    public String encode(CharSequence rawPassword) {
        return PREFIX + this.idForEncode + SUFFIX + this.passwordEncoderForEncode.encode(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String prefixEncodedPassword) {
        if (rawPassword == null && prefixEncodedPassword == null) {
            return true;
        }
        String id = extractId(prefixEncodedPassword);
        PasswordEncoder delegate = this.idToPasswordEncoder.get(id);
        if (delegate == null) {
            return this.defaultPasswordEncoderForMatches.matches(rawPassword, prefixEncodedPassword);
        }
        String encodedPassword = extractEncodedPassword(prefixEncodedPassword);
        return delegate.matches(rawPassword, encodedPassword);
    }

    private String extractId(String prefixEncodedPassword) {
        if (prefixEncodedPassword == null) {
            return null;
        }
        int start = prefixEncodedPassword.indexOf(PREFIX);
        if (start != 0) {
            return null;
        }
        int end = prefixEncodedPassword.indexOf(SUFFIX, start);
        if (end < 0) {
            return null;
        }
        return prefixEncodedPassword.substring(start + 1, end);
    }

    @Override
    public boolean upgradeEncoding(String prefixEncodedPassword) {
        String id = extractId(prefixEncodedPassword);
        if (!this.idForEncode.equalsIgnoreCase(id)) {
            return true;
        }
        else {
            String encodedPassword = extractEncodedPassword(prefixEncodedPassword);
            return this.idToPasswordEncoder.get(id).upgradeEncoding(encodedPassword);
        }
    }

    private String extractEncodedPassword(String prefixEncodedPassword) {
        int start = prefixEncodedPassword.indexOf(SUFFIX);
        return prefixEncodedPassword.substring(start + 1);
    }

    /**
     * Default {@link PasswordEncoder} that throws an exception telling that a suitable
     * {@link PasswordEncoder} for the id could not be found.
     */
    private class UnmappedIdPasswordEncoder implements PasswordEncoder {

        @Override
        public String encode(CharSequence rawPassword) {
            throw new UnsupportedOperationException("encode is not supported");
        }

        @Override
        public boolean matches(CharSequence rawPassword, String prefixEncodedPassword) {
            String id = extractId(prefixEncodedPassword);
            throw new IllegalArgumentException("There is no PasswordEncoder mapped for the id \"" + id + "\"");
        }

    }
}
