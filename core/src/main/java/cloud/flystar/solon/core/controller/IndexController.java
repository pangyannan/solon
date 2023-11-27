package cloud.flystar.solon.core.controller;

import cloud.flystar.solon.commons.bean.dto.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RequestMapping
@RestController
public class IndexController {
    @GetMapping(path = {"/","/index"})
    public Result<String> index(){
        return Result.successBuild("index");
    }
}
