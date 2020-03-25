package com.atguigu.atcrowdfunding.service.impl;

import com.atguigu.atcrowdfunding.Utils.CodeUtil;
import com.atguigu.atcrowdfunding.Utils.SendEmailUtil;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.dao.UserDao;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.imageio.IIOException;
import javax.mail.MessagingException;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    private SendEmailUtil sendEmailUtil;

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

    public List<User> queryLoginEmail(User user){
        return userDao.queryLoginEmail(user);
    }

    public void sendEmail() {

        String toEmail = "2489801340@qq.com";
        String code = null;
        CodeUtil codeUtil = new CodeUtil();
        code = codeUtil.generateUniqueCode();
        try{
            sendEmailUtil.send_email(toEmail,code);
        } catch (IOException e){
            e.printStackTrace();
        }catch (MessagingException e){
            e.printStackTrace();
        }
    }

}
