package com.atguigu.atcrowdfunding.dao;

import com.atguigu.atcrowdfunding.bean.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface UserDao {

    @Select("select * from t_user")
    List<User> queryAll();

    @Select("select * from t_user where loginacct = #{loginacct} and userpswd = #{userpswd}")
    User query4Login(User user);

    List<User> pageQueryData(Map<String,Object> map);

    int pageQueryCount(Map<String,Object> map);

    @Insert("insert into  t_user (username,loginacct,userpswd,email) values (#{username},#{loginacct},#{userpswd},#{email})")
    void saveUser(User user);

    int query4LoginEmail(User user);



}
