package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户表
 * 一般是和用户这个人相关的最基本信息，不要掺杂过多其他属性
 */
@Data
public class UserInfo {

    /** 用户ID */
    private Long userId;

    /** 用户昵称 */
    private String nickName;

    /** 登陆账号 */
    private String userName;

    /** 密码 */
    private String password;

    /** 用户邮箱 */
    private String email;

    /** 手机号码 */
    private String phone;


    /** 帐号状态（0正常 1停用） */
    private Integer status;

    /** 删除标志（0代表未删除 1代表删除）*/
    private Integer deleteFlag;

    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
