<%@ page import="org.rabbit.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/19
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="sidebar1.jsp"%>
<style>
    h1 {
        text-align: center;
    }

    p {
        text-align: right;
    }
</style>
<script src="static/js/date.js"></script>
<%@include file="checkUserLogin.jsp"%>
<div class="container">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2">
            <h1 class="page-header">花店后台管理系统</h1>
            <p>
                <span>欢迎【<%=((User) session.getAttribute("user")).getUserName()%>】</span>
                <span id="showTime"></span>
            </p>
        </div>
    </div>
</div>
<%@ include file="sidebar2.jsp"%>