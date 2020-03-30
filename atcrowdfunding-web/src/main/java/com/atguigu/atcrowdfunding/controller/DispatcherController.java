package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.Utils.MD5Utils;
import com.atguigu.atcrowdfunding.Utils.SendMail;
import com.atguigu.atcrowdfunding.bean.AJAXResult;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class DispatcherController {

    @Autowired
    private UserService userService;




    /**
     * 返回到登录页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        //session.removeAttribute("loginUser");
        session.invalidate();
        return "redirect:login";
    }

    /**
     * 跳转到首页
     * @return
     */
    @RequestMapping("/main")
    public String mian(){
        return "main";
    }

    /**
     * 跳转到注册页面
     * @return
     */
    @RequestMapping("/reg")
    public String reg() {
        return "reg";
    }

    /**
     * 跳转到找回密码页面
     * @return
     */

    @RequestMapping("/forget")
    public String forget() {
        return "forget";
    }

    /**
     * 登录验证
     * @param user
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping("/doAJXLogin")
    public Object doAJXLogin(User user, HttpSession session){

        AJAXResult result = new AJAXResult();

        String pswd = MD5Utils.md5(user.getUserpswd());
        user.setUserpswd(pswd);
        User dbUser = userService.query4Login(user);
        if(dbUser != null){

            session.setAttribute("loginUser",dbUser);
            result.setSuccess(true);
        }else {
            result.setSuccess(false);

        }
        return result;
    }

    /**
     * 执行登录反馈
     * @return
     */
    @RequestMapping("/dologin")
    public String doLogin(User user, Model model) throws Exception {

        String loginacct = user.getLoginacct();

        //将乱码字符串按照错误的解码方式转换为原始的字节码序列
        byte[] bs = loginacct.getBytes("ISO8859-1");


        //将原始的字节码序列按照正确的编码转换为正确的文字即可
        loginacct = new String(bs,"UTF-8");

        //1)获取表单数据
        //1.1）HttpServletRequest
        //1.2)在方法参数列表中增加表单对应的参数，名称相同
        //1.3)就是将表单数据封装为实体类对象
        //2)查询用户信息
        User dbUser = userService.query4Login(user);
        //3）判断用户信息是否存在
        if(dbUser != null){
            //登录成功，跳转到主页面
            return "main";
        }else {
            //登入失败，跳转回登录页面，提示错误信息
            String errorMsg = "登录账号或密码不正确，请重新输入";
            model.addAttribute("errorMsg",errorMsg);
            return "redirect:login";
        }


    }

    /**
     * 执行注册
     * @param user
     * @return
     */

    @ResponseBody
    @RequestMapping("/saveUser")
    public Object saveUser(User user){

        AJAXResult result = new AJAXResult();

        String pswd = MD5Utils.md5(user.getUserpswd());
        user.setUserpswd(pswd);


        int countLogin = userService.queryLogin(user);

        int countEmail = userService.queryEmail(user);

        int i = 0;
        if (countLogin > 0 || countEmail > 0 ){

            if ( countLogin > 0 ) {
                result.setSuccrsss(1);
                i = result.getSuccrsss();
                System.out.println("用户名获取"+i);

            }else{
                result.setSuccrsss(2);
                i = result.getSuccrsss();

                System.out.println("邮箱获取"+i);


            }



        }else {
            userService.saveUser(user);
            result.setSuccrsss(0);
            System.out.println("数据为"+i);

        }


        return result;
    }

    //获取验证码功能
    @RequestMapping("/doPost")
    @ResponseBody
    public Object doPost(User user, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AJAXResult result = new AJAXResult();

        // 获取用户的邮箱
        // 实例化用户对象
        //User user = null;
        // 实例化一个发送邮件的对象
        SendMail mySendMail = new SendMail();
        // 根据页面获取到的邮箱找到该用户信息
       User users = userService.getUserByEmail(user);
        // 如果查到该用户，并且用户名和页面输入相同验证成功，发送邮件
        if (users != null) {
            //生成6位验证码
            result.setRandom ((int)((Math.random()*9+1)*100000));
            mySendMail.sendMail(users.getEmail(), "尚筹网-创意产品众筹平台，您的密码为：" + result.getRandom());
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }
        return result;
    }


    //获取验证码功能
    @ResponseBody
    @RequestMapping("/updateUserPswd")
    public Object updateUserPswd(User user) {
        AJAXResult result = new AJAXResult();

        User users = userService.getUserByEmail(user);

        if (users != null && result.getRandom() == user.getRandom()) {
            String pswd = MD5Utils.md5(user.getUserpswd());
            user.setUserpswd(pswd);
            userService.updateUserPswd(user);
            result.setSuccess(true);
        }else {
            result.setSuccess(false);
        }

        return result;
    }

}
