<%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/19
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>花之舞</title>

    <link rel="stylesheet"  type="text/css" href="https://apps.bdimg.com/libs/bootstrap/3.3.4/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="static/css/sidebar.css">
    <style>
        #page-content-wrapper {
            background-color: #ce7d88;
        }
    </style>
</head>
<body>

<div id="wrapper" style="margin-top: -60px">
    <div class="overlay"></div>

    <!-- Sidebar -->
    <nav class="navbar navbar-inverse navbar-fixed-top" id="sidebar-wrapper" role="navigation">
        <ul class="nav sidebar-nav">
            <li class="sidebar-brand">
                <a href="#">花店后台管理</a>
            </li>
            <li>
                <a href="#" class="home"><i class="fa fa-fw fa-home"></i>主页</a>
            </li>
            <%
//                User user = (User) session.getAttribute("user");
                int userFlag = user.getUserFlag();
                if("1".equals(String.valueOf(userFlag))) {
            %>
            <li>
                <a href="#" class="flower"><i class="fa fa-fw fa-cog"></i>鲜花管理</a>
            </li>
            <li>
                <a href="#" class="flowerType"><i class="fa fa-fw fa-file-code-o"></i>鲜花种类管理</a>
            </li>
            <li>
                <a href="#" class="supplier"><i class="fa fa-fw fa-cog"></i>供应商管理</a>
            </li>
            <li>
                <a href="#" class="userService"><i class="fa fa-fw fa-user"></i>用户管理</a>
            </li>
            <li>
                <a href="#" class="orderService"><i class="fa fa-fw fa-file-o"></i>订单管理</a>
            </li>
            <%
                }
            %>
            <li>
                <a href="#" class="userInfo"><i class="fa fa-fw fa-user-md"></i>个人信息管理</a>
            </li>
            <li>
                <a href="#" class="shopping"><i class="fa fa-fw fa-shopping-cart"></i>鲜花购买</a>
            </li>
            <li>
                <a href="login.jsp"><i class="fa fa-fw fa-twitter"></i>退出系统</a>
            </li>
        </ul>
    </nav>
    <!-- sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">
        <button type="button" class="hamburger is-closed animated fadeInLeft" data-toggle="offcanvas">
            <span class="hamb-top"></span>
            <span class="hamb-middle"></span>
            <span class="hamb-bottom"></span>
        </button>
