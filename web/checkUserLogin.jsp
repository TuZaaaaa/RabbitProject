<%@ page import="org.rabbit.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/18
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        // 验证用户登录
        User user = (User) session.getAttribute("user");
        System.out.println(user);
        System.out.println(user.getUserName());
        if(user == null) {
            response.sendRedirect("login.jsp");
            out.print("<script>top.location.href='login.jsp'</script>");
            return;
        }
    %>
</body>
</html>
