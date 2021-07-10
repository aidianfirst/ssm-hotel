package com.tang.controller;

import com.alibaba.fastjson.JSON;
import com.tang.pojo.User;
import com.tang.service.UserService;
import com.tang.utils.SystemConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping("/register")
    public String register(User user){
        Map<String, Object> map = new HashMap<String, Object>();
        if(userService.addUser(user) > 0){
            map.put(SystemConstant.SUCCESS,true);
            map.put(SystemConstant.MESSAGE,"注册成功");
        }else{
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"注册失败，请重新尝试");
        }
        return JSON.toJSONString(map);
    }

    @ResponseBody
    @RequestMapping("/checkName")
    public String checkName(String loginName){
        Map<String, Object> map = new HashMap<String, Object>();
        if(userService.findUserByName(loginName) != null){
            map.put(SystemConstant.EXIST,true);
            map.put(SystemConstant.MESSAGE,"用户名已存在，请重新输入");
        }else{
            map.put(SystemConstant.EXIST,false);
        }
        return JSON.toJSONString(map);
    }

    @ResponseBody
    @RequestMapping("/login")
    public String login(String loginName, String password, HttpSession session){
        Map<String, Object> map = new HashMap<String, Object>();
        User loginUser = userService.login(loginName, password);
        if(loginUser != null){
            map.put(SystemConstant.SUCCESS,true);
            loginUser.setPassword(null);//安全，清空密码
            //session保存用户信息
            session.setAttribute(SystemConstant.FRONT_LOGINUSER,loginUser);
        }else{
            map.put(SystemConstant.SUCCESS,false);
            map.put(SystemConstant.MESSAGE,"登录失败，请重新尝试");
        }
        return JSON.toJSONString(map);
    }

}
