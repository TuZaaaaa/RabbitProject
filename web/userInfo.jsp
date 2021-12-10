<%@ page import="org.rabbit.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/12/2
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
<script src="static/js/jquery-3.6.0.js"></script>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: #fff;
    }

    h1 {
        margin-top: 50px;
        text-align: center;
        color: #ce7d88;
    }
    form {
        margin: 0 auto;
        width: 500px;
    }

    table {
        margin: 50px auto;
        text-align: left;
    }
</style>
<body>
    <%
        User user = (User) session.getAttribute("user");
    %>
    <h1>个人信息</h1>
    <form action="userService?action=infoModify" method="post">
        <label for="user-id2">用户id:</label>
        <input type="text" id="user-id2" name="user-id2" class="input-group" readonly value="<%=user.getUserId()%>">
        <label for="user-name2">用户名称:</label>
        <input type="text" id="user-name2" name="user-name2" class="input-group" value="<%=user.getUserName()%>">
        <label for="user-password2">用户密码:</label>
        <input type="password" id="user-password2" name="user-password2" class="input-group" value="<%=user.getUserPassword()%>">
        <label for="user-telephone2">手机号:</label>
        <input type="text" id="user-telephone2" name="user-telephone2" class="input-group" value="<%=user.getUserTelephone()%>">
        <label for="user-email2">邮箱:</label>
        <input type="text" id="user-email2" name="user-email2" class="input-group" value="<%=user.getUserEmail()%>">
        <label for="user-address2">地址:</label>
        <input type="text" id="user-address2" name="user-address2" class="input-group" value="<%=user.getUserAddress()%>">
        <label for="user-flag2">权限:</label>
        <input type="text" id="user-flag2" name="user-flag2" class="input-group" readonly value="<%="1".equals(String.valueOf(user.getUserFlag()))?"管理员":"用户"%>">
        <div class="modal-footer">
            <button type="submit" class="btn btn-success" data-bs-dismiss="modal">修改</button>
            <button type="reset" class="btn btn-primary">重置</button>
        </div>
    </form>
</body>
</html>