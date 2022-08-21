package cloud.flystar.solon.framework.controller;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.log.audit.Audit;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@RequestMapping
@RestController
public class IndexController {
    @GetMapping(path = {"/","/index"})
    public Result<String> index(){
        return Result.successBuild("index");
    }
}
