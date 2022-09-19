package cloud.flystar.solon.app.web.controller;

import cloud.flystar.solon.commons.bean.constant.GlobeConstant;
import cloud.flystar.solon.commons.bean.dto.Result;
import cloud.flystar.solon.commons.format.json.JsonUtil;
import cloud.flystar.solon.user.api.UserApi;
import cloud.flystar.solon.user.api.dto.UserDto;
import cn.dev33.satoken.annotation.SaCheckPermission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;


@RestController
@RequestMapping("/user")
public class UserController {
    private static final String RESOURCE_PREFIX = "user:";
    @Autowired
    public UserApi userApi;

    @Autowired
    private RedisTemplate redisTemplate;


    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @SaCheckPermission(GlobeConstant.RESOURCE_PREFIX + RESOURCE_PREFIX + "get")
    @GetMapping("/get")
    public Result<UserDto> user(@RequestParam(name = "id") Long id){
        UserDto userDto = userApi.getById(id);
        return Result.successBuild(userDto);
    }


    @GetMapping("/redis")
    public Result redis(@RequestParam(name = "id") Long id){
        UserDto userDto = new UserDto();
        userDto.setUserId(id);
        userDto.setUserName("admin");
        stringRedisTemplate.opsForValue().set("admin",JsonUtil.json(userDto));




//        UserDto admin = (UserDto) redisTemplate.opsForValue().get("admin");

        String adminJson = stringRedisTemplate.opsForValue().get("admin");
        UserDto userDto1 = JsonUtil.jsonToBean(adminJson, UserDto.class);


        List<UserDto> list = Arrays.asList(userDto,userDto,userDto,userDto);
        redisTemplate.opsForValue().set("adminList",list);
        List<UserDto> adminList = (List<UserDto>) redisTemplate.opsForValue().get("adminList");


        return Result.successBuild(adminList);
    }
}
