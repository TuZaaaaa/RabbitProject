<%@ page import="org.rabbit.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/19
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="checkUserLogin.jsp"%>
<%@ include file="sidebar1.jsp"%>
<style>
    h1 {
        text-align: center;
    }

    p {
        text-align: right;
    }

    iframe {
        width: 1300px;
        height: 650px;
        border-radius: 50px;
        border: 5px solid #bfb1c9;
    }
</style>
<script src="static/js/date.js"></script>
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
    <iframe src="flower.jsp" frameborder="0"></iframe>
</div>
<%@ include file="sidebar2.jsp"%>
<script>
    $(function() {
        toggleFrame('.home', 'flower.jsp')
        toggleFrame('.flower', 'flowerService?action=queryAll')
        toggleFrame('.flowerType', 'flowerTypeService?action=queryAll')
        toggleFrame('.supplier', 'supplierService?action=queryAll')
        toggleFrame('.userService', 'userService?action=queryAll')
        toggleFrame('.orderService', 'orderService?action=queryAll')
        toggleFrame('.userInfo', 'userInfo.jsp')
        toggleFrame('.shopping', 'flowerService?action=shopping')
    })

    function toggleFrame(target, src) {
        $(target).click(function() {
            $("iframe",parent.document.body).attr("src", src)
        })
    }
</script>