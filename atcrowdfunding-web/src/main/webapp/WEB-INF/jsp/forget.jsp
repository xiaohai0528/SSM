<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 找回密码</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" name="userpswd" for="password" placeholder="请输入新密码"  style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userspswd" name="userspswd" for="password" placeholder="再次请输入新密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <div class="form-group">
            <div class="input-group has-success has-feedback">
                <input type="text" class="form-control" id="usercode" name="usercode" placeholder="请输入验证码">
                <label class="input-group-btn has-success has-feedback">
                    <a class="btn form-control btn-success" onclick="sendemail()" >发送验证码</a>
                </label>
            </div>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
        </div>

        <div>
            <input type="checkbox" id="togglePassword"><label for="togglePassword">显示密码</label>
        </div>


        <a class="btn btn-lg btn-success"  onclick="dologin()" > 找 回 密 码 </a>



        <label style="float:right">
            <a class="btn btn-lg btn-success" href="login" >   返 回 登 录 </a>
        </label>











    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="jquery/jquery.toggle-password.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="layer/layer.js"></script>
<script>
    $(function(){
        $('#userpswd').togglePassword({
            el: '#togglePassword'
        });
        $('#userspswd').togglePassword({
            el: '#togglePassword'
        });
    });

    function sendemail() {
        var loginacct = $("#loginacct").val();
        var userpswd = $("#userpswd").val();
        var userspswd = $("#userspswd").val();
        var email = $("#email").val()
        //表单元素value取值不会为null，取值是空字符串
        if (loginacct == "") {
            layer.msg("用户名不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }
        if (email == "") {
            layer.msg("邮箱不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }
        var loadingIndex =null;
        $.ajax({
            url: "doPost",
            data : {
                "loginacct":loginacct,
                "email":email
            },
            async : false,

            beforeSend : function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    loadingIndex = layer.msg("验证码发送成功", {icon: 16});
                }else {
                    layer.msg("未找到该邮箱，请输入正确的邮箱", {time:3000, icon:5, shift:6}, function () {

                    });
                }

            }
        });




        /* var type = $(":selected").val();
         if ( type == "user" ) {
             window.location.href = "main.html";
         } else {
             window.location.href = "member.html";
         }*/
    }

    function dologin() {
        //非空校验
        var loginacct = $("#loginacct").val();
        var userpswd = $("#userpswd").val();
        var userspswd = $("#userspswd").val();
        var usercode = $("#usercode").val();
        var email = $("#email").val()
        //表单元素value取值不会为null，取值是空字符串
        if (loginacct == "") {
            layer.msg("用户名不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }
        if (email == "") {
          layer.msg("邮箱不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

          });

          return;
        }
        if (userpswd == "") {
            layer.msg("新密码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }
        if (userspswd == "") {
            layer.msg("新密码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }

        if (userpswd != userspswd) {
            layer.msg("两次密码不一致，请重新输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }



        if (usercode == "") {
            layer.msg("验证码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });

            return;
        }



        //提交表单
        //alert("提交表单 ");
        //$("#loginForm").submit();
        //使用AJAX提交数据

        var loadingIndex =null;
        $.ajax({
            type : "POST",
            url  : "saveUser",
            data : {
                "userpswd" : userpswd,
                "usercode" : usercode,
                "email" : email
            },
            beforeSend : function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    loadingIndex = layer.msg("密码修改成功", {icon: 16});
                }else {
                    layer.msg("验证码输入错误，请重新输入", {time:3000, icon:5, shift:6}, function () {

                    });
                }

            }
        });


        /* var type = $(":selected").val();
         if ( type == "user" ) {
             window.location.href = "main.html";
         } else {
             window.location.href = "member.html";
         }*/
    }
</script>
</body>
</html>