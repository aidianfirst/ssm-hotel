package com.tang.service;

import com.tang.dao.UserMapper;
import com.tang.pojo.User;
import com.tang.utils.PasswordUtil;
import com.tang.utils.SystemConstant;
import com.tang.utils.UUIDUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    public int addUser(User user) {
        //设置加密盐值
        user.setSalt(UUIDUtils.randomUUID());
        //密码加密
        user.setPassword( PasswordUtil.md5(user.getPassword(),user.getSalt(), SystemConstant.PASSWORD_COUNT) );
        return userMapper.addUser(user);
    }

    public User findUserByName(String loginName) {
        return userMapper.findUserByName(loginName);
    }

    public User login(String loginName, String password) {
        //查询用户信息
        User loginUser = userMapper.findUserByName(loginName);
        if(loginUser != null){
            //输入的是用户的未加密密码，先密码加密
            String newPassword = PasswordUtil.md5(password,loginUser.getSalt(),SystemConstant.PASSWORD_COUNT);
            //然后在数据库内比较加密后密码是否相等
            if(loginUser.getPassword().equals(newPassword)){
                return loginUser;
            }
        }
        return null;
    }

}
