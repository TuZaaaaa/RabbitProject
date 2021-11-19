<%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/18
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>全覆盖响应式导航菜单</title>
    <link rel="stylesheet" href="static/css/nav.css">
</head>

<body>
<!-- icon按钮 -->
<div id="toggleIcon" onclick="menuToggle()"></div>
<div id="menu-overlay">
    <ul>
        <li><a href="#">主页</a></li>
        <li><a href="#">个人信息</a></li>
        <li><a href="#">花</a></li>
        <li><a href="#">订单</a></li>
        <li><a href="login.jsp">退出</a></li>
    </ul>
</div>
<script>
    function menuToggle() {
        var nav = document.getElementById('menu-overlay')
        // 点击切换添加类名
        nav.classList.toggle('active')
        var tog = document.getElementById('toggleIcon')
        tog.classList.toggle('active')
    }
</script>
</body>

</html>