package cloud.flystar.solon.sequence.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 流水号生成器核心入口服务
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class SerialNoGenerator {
    private final SequenceSegmentService sequenceSegmentService;
    private final SequenceConfigService sequenceConfigService;

    
}
