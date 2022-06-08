package cloud.flystar.solon.framework.controller;

import cloud.flystar.solon.common.dto.Result;
import cloud.flystar.solon.common.log.audit.Audit;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RequestMapping
@RestController
public class IndexController {
    @GetMapping(path = {"/","/index"})
//    @Log
    @Audit
    public Result<String> index(){
        return Result.successBuild("index");
    }
}
