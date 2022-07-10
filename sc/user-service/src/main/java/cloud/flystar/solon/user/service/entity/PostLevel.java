package cloud.flystar.solon.user.service.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 岗位
 */
@Data
public class PostLevel {
    /** 职级ID*/
    private Long postLevelId;

    /** 职级编码 */
    private String postLevelCode;

    /** 职级名称 */
    private String postLevelName;
    
    /** 职级描述 */
    private String postLevelMark;

    /** 状态（0正常 1停用） */
    private String status;


    private LocalDateTime createTime;
    private Long createUserId;
    private LocalDateTime updateTime;
    private Long updateUserId;
}
