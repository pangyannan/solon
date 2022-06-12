package cloud.flystar.solon.user.api.dto;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UserDto {
    private Long id;
    private String userName;
    private String phone;
    private String email;
}
