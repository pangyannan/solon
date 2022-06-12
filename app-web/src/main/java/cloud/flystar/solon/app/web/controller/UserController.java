package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.dto.Result;
import cloud.flystar.solon.user.api.UserService;
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
    public UserService userService;

    @GetMapping("/get")
    public Result<UserDto> user(@RequestParam(name = "id") Long id){
        UserDto userDto = userService.getUserDtoById(id);
        return Result.successBuild(userDto);
    }
}
