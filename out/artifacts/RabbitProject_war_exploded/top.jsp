<%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/18
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            background: #cbc0d3;
            color: #fff;
        }

        #title {
            margin: 0 auto;
            text-align: center;
        }

        #info {
            margin: 0 auto;
            text-align: center;
        }
    </style>
    <script src="static/js/date.js"></script>
</head>
<body>
    <%-- 验证用户是否登录 --%>
    <%@include file="checkUserLogin.jsp"%>
    <div id="title">花店商品信息管理系统-后台管理</div>
    <hr>
    <div id="info">
        <%
            System.out.println(user.getUserName());
        %>
        <span>您好：【<%=user.getUserName()%>】</span>
        <span id="showTime"></span>
    </div>
</body>
</html>