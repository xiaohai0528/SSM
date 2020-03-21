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
            <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
            <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="userpswd" name="userpswd" placeholder="请输入新密码" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="usercode" name="usercode" placeholder="请输入邮箱验证码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>

        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option>会员</option>
                <option>管理</option>
            </select>
        </div>

        <a class="btn btn-lg btn-success btn-block" onclick="dologin()" > 找 回 密 码</a>
    </form>
</div>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="layer/layer.js"></script>
<script>
    function dologin() {
        //非空校验
        var userpswd = $("#userpswd").val();
        var usercode = $("#usercode").val();
        var email = $("#email").val()
        //表单元素value取值不会为null，取值是空字符串
        if (userpswd=="" && usercode == ""&& email == "") {

            layer.msg("邮箱，新密码和验证码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

            });
            return;

        }else{
            if (email == "") {
                layer.msg("邮箱不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录账号不能为空，请输入");
                return;
            }


            if (userpswd == "") {
                layer.msg("新密码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

                });
                //alert("用户登录账号不能为空，请输入");
                return;
            }


            if (usercode == "") {
                layer.msg("验证码不能为空，请输入", {time: 3000, icon: 5, shift: 6}, function () {

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