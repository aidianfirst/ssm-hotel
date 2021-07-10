package com.tang.dao;

import com.tang.pojo.User;

public interface UserMapper {
    int addUser(User user);

    User findUserByName(String loginName);

}
