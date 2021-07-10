package com.tang.service;

import com.tang.pojo.User;

public interface UserService {
    int addUser(User user);

    User findUserByName(String loginName);

    User login(String loginName,String password);
}
