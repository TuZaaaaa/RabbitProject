<%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/18
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="http://localhost:8080/Flower/">
</head>
    <frameset rows="100, *, 100" frameborder="no">
        <frame name="top" src="top.jsp" scrolling="no"/>
        <frameset cols="160, *" scrolling="no">
            <frame src="left.jsp">
            <frame src="main.jsp">
        </frameset>
    </frameset>
</html>