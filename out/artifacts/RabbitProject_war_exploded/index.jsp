<%@ page import="org.rabbit.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/18
  Time: 7:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
    <base href="http://localhost:8080/Flower/">
    <script src="static/js/date.js"></script>
</head>
    <script>
        function changeImage() {
            document.getElementById('safeCode').src = 'safeCode?rnd=' + Math.random() * 100
        }
    </script>
<%@include file="nav.jsp"%>
<body>
    <h1>这是我的主页</h1>
    <%
        if(session.getAttribute("user") != null) {
            %>
        <p>您好【<%=((User) session.getAttribute("user")).getUserName()%>】</p>
        <p id="msg"></p>
    <%
        }
    %>
</body>
</html>