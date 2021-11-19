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
    <title>框架左侧菜单</title>
    <style>
        body {
            background: #cbc0d3;
            color: #fff;
            font-weight: 700;
        }

        .box {
            margin: 0 auto;
            width: 140px;
        }

        .box .title {
            margin-bottom: 20px;
            cursor: pointer;
        }

        .con {
            display: none;
        }

        .con ul {
            list-style: none;
        }

        a {
            text-decoration: none;
            color: #fff;
        }

        .con a:hover {
            color: #eac7cc;
            font-weight: 900;
        }
    </style>
    <script>

        function showHide(obj) {
            if(obj.style.display === 'block') {
                obj.style.display = 'none'
            } else {
                obj.style.display = 'block'
            }
        }
    </script>
</head>
<body>
    <%-- 验证用户是否登录 --%>
    <%@include file="checkUserLogin.jsp"%>
    <div class="box">
        <div class="title"><a href="index.jsp" target="top">首页</a></div>
    </div>
    <div class="box">
        <div class="title" onclick="showHide(m1)">鲜花管理</div>
        <div class="con" id="m1">
            <ul>
                <li><a href="javascript:;" target="main">鲜花添加</a></li>
                <li><a href="javascript:;" target="main">鲜花维护</a></li>
            </ul>
        </div>
        <div class="title" onclick="showHide(m2)">鲜花种类管理</div>
        <div class="con" id="m2">
            <ul>
                <li><a href="javascript:;" target="main">鲜花种类添加</a></li>
                <li><a href="javascript:;" target="main">鲜花种类维护</a></li>
            </ul>
        </div>
        <div class="title" onclick="showHide(m3)">供应商管理</div>
        <div class="con" id="m3">
            <ul>
                <li><a href="javascript:;" target="main">供应商添加</a></li>
                <li><a href="javascript:;" target="main">供应商维护</a></li>
            </ul>
        </div>
        <div class="title" onclick="showHide(m4)">用户信息管理</div>
        <div class="con" id="m4">
            <ul>
                <li><a href="javascript:;" target="main">用户管理</a></li>
            </ul>
        </div>
        <div class="title" onclick="showHide(m5)">订单管理</div>
        <div class="con" id="m5">
            <ul>
                <li><a href="javascript:;" target="main">订单管理</a></li>
            </ul>
        </div>
    </div>
    <div class="box">
        <div class="title"><a href="login.jsp" target="top">退出系统</a></div>
    </div>
</body>
</html>