package com.atguigu.atcrowdfunding.service;

import com.atguigu.atcrowdfunding.bean.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    List<User> queryAll();

    User query4Login(User user);

    List<User> pageQueryData(Map<String,Object> map);

    int pageQueryCount(Map<String,Object> map);

    void saveUser(User user);

    User getUserByEmail(User user);


    int queryLogin(User user);

    int queryEmail(User user);

}
