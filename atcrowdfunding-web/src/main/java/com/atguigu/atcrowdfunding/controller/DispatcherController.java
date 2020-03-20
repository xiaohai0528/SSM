package com.atguigu.atcrowdfunding.controller;

import com.atguigu.atcrowdfunding.Utils.MD5Utils;
import com.atguigu.atcrowdfunding.bean.AJAXResult;
import com.atguigu.atcrowdfunding.bean.User;
import com.atguigu.atcrowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

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
     * 执行登录
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

        User dbUser = userService.query4Login(user);



        if(dbUser == null){
            String pswd = MD5Utils.md5(user.getUserpswd());
            user.setUserpswd(pswd);
            userService.saveUser(user);
            result.setSuccess(true);
        }else {
            result.setSuccess(false);

        }

        return result;
    }
}
