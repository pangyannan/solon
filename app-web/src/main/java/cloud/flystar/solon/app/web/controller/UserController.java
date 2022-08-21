package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.app.web.constant.GlobeConstant;
import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.UserDto;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/user")
public class UserController {
    private static final String RESOURCE_PREFIX = "user:";
    @Autowired
    public UserApi userApi;


    @SaCheckPermission(GlobeConstant.RESOURCE_PREFIX + RESOURCE_PREFIX + "get")
    @GetMapping("/get")
    public Result<UserDto> user(@RequestParam(name = "id") Long id){
        userApi.getById(id);
        UserDto userDto = new UserDto();
        userDto.setUserId(id);
        userDto.setUserName("admin");
        String json = JsonUtil.json(userDto);
        UserDto convert = JsonUtil.jsonToBean(json, UserDto.class);
        return Result.successBuild(convert);
    }
}
