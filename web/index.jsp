<%@ page import="java.sql.Connection" %>
<%@ page import="org.rabbit.util.MySqlConnection" %>
<%@ page import="org.rabbit.util.JdbcUtils" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/16
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>花之舞</title>
    <base href="http://localhost:8080/Flower/">
    <link rel="stylesheet" href="static/css/style.css">
    <script src="static/js/jquery-3.6.0.js"></script>
    <script src="static/js/script.js"></script>
</head>
<script>
    function changeImage() {
        document.getElementById('safeCode').src = 'safeCode?rnd=' + Math.random() * 100
    }
</script>

<body>
<%
    Connection connection = MySqlConnection.getConnection();
    System.out.println(connection);
    MySqlConnection.closeConnection();
//    Connection connection = JdbcUtils.getConnection();
//    System.out.println(connection);
%>
<div class="container">
    <div class="welcome">
        <div class="pink-box">
            <!-- 注册 -->
            <div class="register no-display">
                <h1>Register</h1>
                <form action="userService" autocomplete="off">
                    <input type="text" placeholder="Username">
                    <input type="email" placeholder="Email">
                    <input type="password" placeholder="Password">
                    <input type="password" placeholder="Confirm Password">
                    <button class="button submit">Create Account</button>
                </form>
            </div>

            <!-- 登录 -->
            <div class="login">
                <h1>Sign In</h1>
                <form action="userService" class="more-padding" autocomplete="off">
                    <input type="text" name="user_name" placeholder="请输入用户名" required>
                    <input type="password" name="user_password" placeholder="请输入密码" required>
                    <span class="user">
                        <input type="radio" id="user_admin" name="user_flag" value="1">
                        <label for="user_admin">管理员</label>
                        <input type="radio" id="user_user" name="user_flag" value="1" checked="checked">
                        <label for="user_user">用户</label>
                    </span>
                    <span class="code">
                      <input type="text" class="safe_code" name="safe_code" placeholder="验证码">
                      <img  src="safeCode" id="safeCode" style="vertical-align: middle;cursor: pointer" title="看不清换一张"
                            onclick="return changeImage()">
                    </span>
                    <div class="checkbox">
                        <input type="checkbox" id="remember" />
                        <label for="remember">Remember Me</label>
                    </div>
                    <button class="button submit">Login</button>
                </form>
            </div>
        </div>

        <div class="left-box">
            <h2 class="title"><span>BLOOM</span>&<br>BOUQUET</h2>
            <p class="desc">Pick your perfect <span>bouquet</span></p>
            <img class="flower smaller" src="static/img/flower.webp" />
            <p class="account">Have an account?</p>
            <button class="button" id="login">Login</button>
        </div>

        <div class="right-box">
            <h2 class="title"><span>BLOOM</span>&<br>BOUQUET</h2>
            <p class="desc">Pick your perfect <span>bouquet</span></p>
            <img class="flower" src="static/img/flower.webp" />
            <p class="account">Don't have an account?</p>
            <button class="button" id="register">Sign Up</button>
        </div>
    </div>
</div>
</body>
</html>