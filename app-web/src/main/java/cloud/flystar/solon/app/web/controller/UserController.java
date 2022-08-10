package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    public UserApi userApi;

    @GetMapping("/get")
    public Result<UserDto> user(@RequestParam(name = "id") Long id){
        UserDto userDto = userApi.getById(id);
        userDto.setUserId(null);
        String json = JsonUtil.json(userDto);
        UserDto convert = JsonUtil.jsonToBean(json, UserDto.class);
        return Result.successBuild(convert);
    }
}
