package cloud.flystar.solon.common.base;

import lombok.extern.slf4j.Slf4j;

import java.util.*;

/**
 * @Author: pangyannan
 * @Data: 2021/6/14
 * @Description:
 */
@Slf4j
public class TraceServiceSelector {
    private static  TraceService traceService;
    static
    {
        ServiceLoader<TraceService> traceServices = ServiceLoader.load(TraceService.class);
        List<TraceService> list = new ArrayList<>();
        if(traceServices != null){
            traceServices.forEach(t -> list.add(t));
        }
        list.stream()
                .sorted(Comparator.comparing(TraceService::order))
                .findFirst()
                .ifPresent(t-> traceService = t);
    }

    private TraceServiceSelector(){ }

    /**
     * 获取traceId
     * @return
     */
    public static String getTraceId(){
        if(traceService != null){
            return traceService.getTraceId();
        }
        return null;
    }
}
