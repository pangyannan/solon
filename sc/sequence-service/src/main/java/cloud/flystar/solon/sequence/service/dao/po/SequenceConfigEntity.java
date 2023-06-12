package cloud.flystar.solon.sequence.service.dao.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 流水号配置表实体
 */
@Data
@TableName("sequence_config")
public class SequenceConfigEntity {
    /** 流水号配置ID */
    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    /**
     * 业务类型编码 全局唯一
     * 一半来说不同的业务使用不同的业务类型
     * 规范：
     * 1.如果有多级，则用-分割
     * 2.采用小驼峰方式，编码内容为英文字母
     */
    private String bizCode;

    /**
     * 业务名称
     */
    private String bizName;



    /**
     * 流水号前缀
     */
    private String seqPrefix;

    /**
     * 循环方式
     * NONE: 无循环
     * DATE: 时间循环模式
     */
    private String loopType;
    /**
     * 日期循环，一般常见的循环方式为 天、月
     * 格式：
     * 分：yyyyMMddHHmm
     * 时：yyyyMMddHH
     * 天：yyyyMMdd
     * 月：yyyyMM
     * 年：yyyy
     */
    private String loopCode;

    /**
     * 每个循环的开始数字，一般为 1
     */
    private Long loopNumberMin;

    /**
     * 每个循环的最大数字，超过此数字一般就报错
     * 小于0表示没有限制，一般用-1表示无限制
     */
    private Long loopNumberMax;
    /**
     * 参考 DecimalFormat
     * 数字格式化
     * 举例：循环流水号123，需求为如果不满足6位数字则在前面补充0，则格式化代码为 000000
     */
    private String loopNumberFormat;

    /**
     * 循环分段大小，一般根据并发量估计。一般为 100～10000 即可满足大多数应用
     */
    private Integer loopSegmentStep;

    /**
     * 每个Segment的持续时间，单位秒，到达该时间后，自动切换Segment
     * 注意，Duration应根据节点数、loop内总的可能的Segment上限进行评估，防止耗尽
     * 目的也是为防止序号连续防猜，也为了保证整体趋势递增防止个别节点一直不切换
     */
    private Integer loopSegmentDurationSecond;

    /**
     * 每次流水号增长时的步长范围最小值
     */
    private Long nextNumberRandomMin;

    /**
     * 每次流水号增长时的步长范围最大值，流水号自增数为最小最大值之间的整数
     */
    private Long nextNumberRandomMax;


    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;
    @TableField(fill = FieldFill.INSERT)
    private Long createUserId;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateUserId;

}
