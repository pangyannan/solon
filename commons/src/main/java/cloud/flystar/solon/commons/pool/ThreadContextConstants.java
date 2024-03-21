package cloud.flystar.solon.commons.pool;

import lombok.Getter;

/**
 * 本地线程环境枚举
 */
@Getter
public enum ThreadContextConstants {
    TRACE_ID("Trace-Id","链路追踪ID"),
    TRACE_SPAN_ID("Trace-Span-Id","链路追踪SPAN-ID");


    private String code;
    private String name;

    ThreadContextConstants(String code, String name) {
        this.code = code;
        this.name = name;
    }
}
