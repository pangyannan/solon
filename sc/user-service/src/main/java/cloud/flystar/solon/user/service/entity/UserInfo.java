package cloud.flystar.solon.user.service.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户表
 * 一般是和用户这个人相关的最基本信息，不要掺杂过多其他属性
 */
@Data
@TableName("user_info")
public class UserInfo {

    /** 用户ID */
    @TableId(type = IdType.ASSIGN_ID)
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


    /** 帐号状态（false 禁用 true 启用） */
    private Boolean enable;

    /** 删除标志（false 代表未删除 true 代表删除）*/
    private Boolean deleteFlag;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;
}
