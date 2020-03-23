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
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="username" name="username" placeholder="请输入真实姓名" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="userpswd" name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>

            </label>
            <label style="float:right">
                <a href="login.html">我有账号</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 注册</a>
    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="layer/layer.js"></script>
<script>
    function dologin() {
        //非空校验
        var username = $("#username").val();
        var loginacct = $("#loginacct").val();
        var userpswd = $("#userpswd").val();
        var email = $("#email").val()
        //表单元素value取值不会为null，取值是空字符串
        if (username=="" && loginacct == "" && userpswd == "" && email == "") {

            layer.msg("姓名，账号，密码和邮箱不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });
            return;

        }else{
            if (username == "") {
                layer.msg("姓名不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录账号不能为空，请输入");
                return;
            }


            if (loginacct == "") {
                layer.msg("账号不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录账号不能为空，请输入");
                return;
            }


            if (userpswd == "") {
                layer.msg("密码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录密码不能为空，请输入");
                return;
            }
            if (email == "") {
                layer.msg("邮箱不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录密码不能为空，请输入");
                return;
            }

        }

        //提交表单
        //alert("提交表单");
        //$("#loginForm").submit();
        //使用AJAX提交数据
        var loadingIndex =null;
        $.ajax({
            type : "POST",
            url  : "saveUser",
            data : {
                "username" : username,
                "loginacct" : loginacct,
                "userpswd" : userpswd,
                "email" : email
            },
            beforeSend : function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success : function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    loadingIndex = layer.msg("注册成功", {icon: 16});
                }else {
                    layer.msg("用户名或者邮箱已存在，无法注册", {time:3000, icon:5, shift:6}, function () {

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