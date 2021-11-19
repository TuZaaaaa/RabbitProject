<%@ page import="java.sql.Connection" %>
<%@ page import="org.rabbit.util.MySqlConnection" %>
<%@ page import="org.rabbit.util.JdbcUtils" %>
<%--
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
    <link rel="stylesheet" href="static/css/login.css">
    <script src="static/js/jquery-3.6.0.js"></script>
    <script src="static/js/login.js"></script>
</head>
<style>
    body {
        background: #cbc0d3;
    }

    /* 容器的样式 */
    .container {
        margin: auto;
        width: 650px;
        height: 550px;
        position: relative;
    }

    .welcome {
        background: #f6f6f6;
        width: 650px;
        height: 415px;
        position: absolute;
        top: 25%;
        border-radius: 5px;
        box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1);
    }

    .pink-box {
        position: absolute;
        top: -10%;
        left: 5%;
        background: #eac7cc;
        width: 320px;
        height: 500px;
        border-radius: 5px;
        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
        transition: all 0.5s ease-in-out;
        z-index: 2;
    }

    .no-display {
        display: none;
        transition: all 0.5s ease;
    }

    .left-box, .right-box {
        position: absolute;
        width: 50%;
        transition: 1s all ease;
    }

    .left-box {
        left: -2%;
    }

    .right-box {
        right: -2%;
    }

    /* 字体和按钮的样式 */
    h1 {
        font-family: "Open Sans", sans-serif;
        text-align: center;
        margin-top: 95px;
        text-transform: uppercase;
        color: #f6f6f6;
        font-size: 2em;
        letter-spacing: 8px;
    }

    .title {
        font-family: "Lora", serif;
        color: #8e9aaf;
        font-size: 1.8em;
        line-height: 1.1em;
        letter-spacing: 3px;
        text-align: center;
        font-weight: 300;
        margin-top: 20%;
    }

    .desc {
        margin-top: -8px;
    }

    .account {
        margin-top: 45%;
        font-size: 10px;
    }

    p {
        font-family: "Open Sans", sans-serif;
        font-size: 0.7em;
        letter-spacing: 2px;
        color: #8e9aaf;
        text-align: center;
    }

    span {
        color: #eac7cc;
    }

    .flower {
        position: absolute;
        width: 150px;
        height: 150px;
        top: 45%;
        left: 27%;
        opacity: 0.8;
    }

    .smaller {
        width: 130px;
        height: 130px;
        top: 48%;
        left: 30%;
        opacity: 0.9;
    }

    button {
        padding: 12px;
        font-family: "Open Sans", sans-serif;
        text-transform: uppercase;
        letter-spacing: 3px;
        font-size: 11px;
        border-radius: 10px;
        margin: auto;
        outline: none;
        display: block;
    }

    button:hover {
        background: #eac7cc;
        color: #f6f6f6;
        transition: background-color 1s ease-out;
    }

    .button {
        margin-top: 3%;
        background: #f6f6f6;
        color: #ce7d88;
        border: solid 1px #eac7cc;
    }

    /* 表单样式 */
    form {
        display: flex;
        align-items: center;
        flex-direction: column;
        padding-top: 7px;
    }

    .more-padding {
        padding-top: 35px;
    }

    .more-padding input {
        padding: 12px;
    }

    .more-padding .submit {
        margin-top: 45px;
    }

    .submit {
        margin-top: 25px;
        padding: 12px;
        border-color: #ce7d88;
    }

    .submit:hover {
        background: #cbc0d3;
        border-color: #bfb1c9;
    }

    input {
        background: #eac7cc;
        width: 65%;
        color: #ce7d88;
        border: none;
        border-bottom: 1px solid rgba(246, 246, 246, 0.5);
        padding: 9px;
        font-weight: 100;
    }

    input::placeholder {
        color: #f6f6f6;
        letter-spacing: 2px;
        font-size: 1.0em;
        font-weight: 100;
    }

    input:focus {
        color: #ce7d88;
        outline: none;
        border-bottom: 1px solid rgba(206, 125, 136, 0.7);
        font-size: 1.0em;
        transition: 0.8s all ease;
    }

    input:focus::placeholder {
        opacity: 0;
    }

    .more-padding .user {
        margin-top: 10px;
        width: 180px;
    }

    .more-padding .user input {
        width: 13px;
        height: 13px;
        vertical-align: middle;
    }

    .more-padding .code {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
        width: 190px;
    }

    .safe_code {
        text-align: left;
        width: 50px;
    }

    label {
        font-family: "Open Sans", sans-serif;
        color: #ce7d88;
        font-size: 0.8em;
        letter-spacing: 1px;
    }

    .checkbox {
        display: inline;
        position: relative;
        white-space: nowrap;
        left: -52px;
        top: 25px;
    }

    .checkbox #remember {
        vertical-align: middle;
    }

    input[type=checkbox] {
        width: 15px;
        background: #ce7d88;
    }

    .checkbox input[type=checkbox]:checked + label {
        color: #ce7d88;
        transition: 0.5s all ease;
    }

</style>
<script>
    function changeImage() {
        document.getElementById('safeCode').src = 'safeCode?rnd=' + Math.random() * 100
    }
</script>

<body>
<%
    String info = (String) session.getAttribute("info");
    if(info != null) {
        %>
    <p><%=info%></p>
<%
    }
    session.removeAttribute("info");
%>
<div class="container">
    <div class="welcome">
        <div class="pink-box">
            <!-- 注册 -->
            <div class="register no-display">
                <h1>Register</h1>
                <form action="userService" method="post" autocomplete="off">
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
                <form action="userService?action=login" method="post" class="more-padding" autocomplete="off">
                    <input type="text" name="user_name" placeholder="请输入用户名" required>
                    <input type="password" name="user_password" placeholder="请输入密码" required>
                    <span class="user">
                        <input type="radio" id="user_admin" name="user_flag" value="1">
                        <label for="user_admin">管理员</label>
                        <input type="radio" id="user_flag" name="user_flag" value="1" checked="checked">
                        <label for="user_flag">用户</label>
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