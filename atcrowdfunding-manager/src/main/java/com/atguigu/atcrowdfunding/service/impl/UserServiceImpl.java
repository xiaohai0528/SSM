package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.dao.UserDao;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;


    public List<User> queryAll() {
        return userDao.queryAll();
    }

    public User query4Login(User user) {
        return userDao.query4Login(user);
    }

    public List<User> pageQueryData(Map<String, Object> map) {
        return userDao.pageQueryData(map);
    }

    public int pageQueryCount(Map<String, Object> map) {
        return userDao.pageQueryCount(map);
    }

    public void saveUser(User user){
        userDao.saveUser(user);
    }

   /* public int query4LoginEmail(User user){
      return userDao.query4LoginEmail(user);
    }*/

    public int queryLogin(User user){
        return userDao.queryLogin(user);
    }

    public int queryEmail(User user){
        return userDao.queryEmail(user);
    }

    public User updateUserPswd(User user) {
        return userDao.updateUserPswd(user);
    }

    public User getUserByEmail(User user){
        return userDao.getUserByEmail(user);
    }




}
