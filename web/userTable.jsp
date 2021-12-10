<%@ page import="org.rabbit.vo.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/12/1
  Time: 8:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
<script src="static/js/jquery-3.6.0.js"></script>
<style>
    * {
        margin: 0;
        padding: 0;
    }

    .box {
        margin: 20px auto;
        width: 1000px;
        height: 600px;
    }

    .table-wrapper {
        height: 350px;
    }

    table {
        text-align: center;
    }

    a {
        text-decoration: none!important;
    }

    .highlight {
        background-color: #cbc0d3!important;
    }

    .pagination {
        justify-content: center;
    }

    p {
        text-align: center;
    }

    .detail-table {
        margin: 0 auto;
        width: 250px;
        height: 350px;
        border-spacing: 30px 0;
    }

    .detail-table td {
        text-align: center;
    }

    .delete {
        color: #ff0000;
    }

    .delete:hover {
        color: #fff;
    }
</style>
<body>

<%
    List<User> userList = (List<User>) session.getAttribute("userList");
    // 1.定义总记录数
    int totalRows = userList.size();

    // 2.定义每页的显示记录数
    int pageSize = 8;

    // 3.计算总分页数
    int pageCount= (int) Math.ceil(totalRows / (pageSize * 1.0));

    // 4.定义或接收当前页索引
    int index = 1;
    if(request.getParameter("index") != null) {
        index = Integer.parseInt(request.getParameter("index"));
    }

    // 5.书写分页查询语句
    int start = (index - 1) * pageSize;
%>
<div class="box">
    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">添加用户</button>
    <button style="display:none" type="button" class="btn btn-outline-info modify" data-bs-toggle="modal" data-bs-target="#myModal2" >修改用户</button>
    <button type="button" class="btn btn-outline-info modifyBtn"><a class="modifyA" href="userService?action=modify&userId=">修改用户</a></button>
    <button style="display: none" type="button" class="btn btn-outline-info detail" data-bs-toggle="modal" data-bs-target="#myModal3"><a>用户信息</a></button>
    <button type="button" class="btn btn-outline-danger deleteBtn"><a class="delete" href="userService?action=delete&userId=">删除用户</a></button>
    <div class="table-wrapper">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>用户 id</th>
                <th>名称</th>
                <th>密码</th>
                <th>手机号</th>
                <th>邮箱</th>
                <th>地址</th>
                <th>权限</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = start;i < start + pageSize;i++) {
                    if (i == userList.size()) {
                        break;
                    }

                    User user = userList.get(i);
            %>
            <tr class="content">
                <td><a class="user-info" href="userService?action=detail&userId=<%=user.getUserId()%>"><%=user.getUserId()%></a></td>
                <td><%=user.getUserName()%></td>
                <td><%=user.getUserPassword()%></td>
                <td><%=user.getUserTelephone()%></td>
                <td><%=user.getUserEmail()%></td>
                <td><%=user.getUserAddress()%></td>
                <td><%="1".equals(String.valueOf(user.getUserFlag()))?"管理员":"用户"%></td>
            </tr>

            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <%
        // 读取当前页面名称
        String fName = request.getServletPath().substring(1);
        // 定义上一页索引
        int prev = index - 1;
        if(prev < 1) {
            prev = 1;
        }
        // 定义下一页索引
        int next = index + 1;
        if(next > pageCount) {
            next = pageCount;
        }
    %>
    <ul class="pagination">
        <%
            if(index > 1) {
        %>
        <li class="page-item"><a class="page-link" href="<%=fName%>?index=1">首页</a></li>
        <li class="page-item"><a class="page-link" href="<%=fName%>?index=<%=prev%>">上一页</a></li>
        <%

        } else {
        %>
        <li class="page-item disabled"><a class="page-link" href="javascript:;">上一页</a></li>
        <li class="page-item disabled"><a class="page-link" href="javascript:;">首页</a></li>
        <%
            }
            for (int i = 1;i <= pageCount;i++) {
                if(i == index) {

        %>
        <li class="page-item active"><a class="page-link" href="<%=fName%>?index=<%=i%>"><%=i%></a></li>

        <%
                continue;
            }
        %>
        <li class="page-item"><a class="page-link" href="<%=fName%>?index=<%=i%>"><%=i%></a></li>
        <%
            }

            if(index < pageCount) {
        %>
        <li class="page-item"><a class="page-link" href="<%=fName%>?index=<%=next%>">下一页</a></li>
        <li class="page-item"><a class="page-link" href="<%=fName%>?index=<%=pageCount%>">尾页</a></li>
        <%
        } else {
        %>
        <li class="page-item disabled"><a class="page-link" href="javascript:;">下一页</a></li>
        <li class="page-item disabled"><a class="page-link" href="javascript:;">尾页</a></li>
        <%

            }
        %>
    </ul>
    <hr>
    <p>共有 <%=totalRows%> 条记录，当前是第 <%=index%> 页，共 <%=pageCount%> 页</p>
    <hr>
</div>

<!-- 模态框 -->
<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">添加用户</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/userService?action=add" method="post">
                <div class="modal-body">
                    <label for="user-id">用户id:</label>
                    <input type="text" id="user-id" name="user-id" class="input-group" value="<%=userList.size() + 1000%>">
                    <label for="user-name">用户名称:</label>
                    <input type="text" id="user-name" name="user-name" class="input-group">
                    <label for="user-password">用户密码:</label>
                    <input type="password" id="user-password" name="user-password" class="input-group">
                    <label for="user-telephone">手机号:</label>
                    <input type="text" id="user-telephone" name="user-telephone" class="input-group">
                    <label for="user-email">邮箱:</label>
                    <input type="text" id="user-email" name="user-email" class="input-group">
                    <label for="user-address">地址:</label>
                    <input type="text" id="user-address" name="user-address" class="input-group">
                    <label for="user-flag">权限:</label>
                    <select class="form-select-button input-group" name="user-flag" id="user-flag">
                        <option value="0">用户</option>
                        <option value="1">管理员</option>
                    </select>
                </div>

                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" data-bs-dismiss="modal">添加</button>
                    <button type="reset" class="btn btn-success">重置</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="modal" id="myModal2">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">修改用户</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/userService?action=update" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行修改操作
                        User user = (User) session.getAttribute("user-modify");
                        if(user != null) {
                            Integer userId = user.getUserId();
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.table tr').eq(<%=userId%>).trigger('click')
                        $('.modify').trigger('click')
                    </script>

                    <label for="user-id2">用户id:</label>
                    <input type="text" id="user-id2" name="user-id2" readonly class="input-group" value="<%=user.getUserId()%>">
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
                    <select class="form-select-button input-group userSelect" name="user-flag2" id="user-flag2">
                        <option value="0">用户</option>
                        <option value="1">管理员</option>
                    </select>
                    <script>
                        <%
                            int userFlag = user.getUserFlag();
                        %>
                        document.querySelector('.userSelect').options[<%=userFlag%>].selected = true;
                    </script>
                    <%
                            // 用完之后移除
                            session.removeAttribute("user-modify");
                        }
                    %>
                </div>

                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" data-bs-dismiss="modal">修改</button>
                    <button type="reset" class="btn btn-success">重置</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="modal" id="myModal3">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">用户信息</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/userService?action=add" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行展示详细信息操作
                        User user1 = (User) session.getAttribute("user-detail");
                        if (user1 != null) {
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.detail').trigger('click')
                    </script>
                    <table class="detail-table" cellspacing="10px">
                        <tr>
                            <td>用户 id：</td>
                            <td><%=user1.getUserId()%></td>
                        </tr>
                        <tr>
                            <td>用户名称：</td>
                            <td><%=user1.getUserName()%></td>
                        </tr>
                        <tr>
                            <td>用户密码：</td>
                            <td><%=user1.getUserPassword()%></td>
                        </tr>
                        <tr>
                            <td>手机号：</td>
                            <td><%=user1.getUserTelephone()%></td>
                        </tr>
                        <tr>
                            <td>邮箱：</td>
                            <td><%=user1.getUserEmail()%></td>
                        </tr>
                        <tr>
                            <td>地址：</td>
                            <td><%=user1.getUserAddress()%></td>
                        </tr>
                        <tr>
                            <td>权限：</td>
                            <td><%="1".equals(String.valueOf(user1.getUserFlag()))?"管理员":"用户"%></td>
                        </tr>
                    </table>
                    <%
                            session.removeAttribute("user-detail");
                        }
                    %>
                </div>

                <!-- 模态框底部 -->
                <div class="modal-footer"></div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

<script>
    // 为表格内容添加点击事件（高亮显示）
    $(".table .content").click(function() {
        let selected = $(this).hasClass("highlight");
        $(".table .content").removeClass("highlight");
        if (!selected) {
            $(this).addClass("highlight");
        }
        // 选中表格项的同时，为 修改和删除按钮的 的 href 赋值
        let id = $(this).find('.user-info').text()
        let modifySrc = 'userService?action=modify&userId=' + id
        let deleteSrc = 'userService?action=delete&userId=' + id
        $('.modifyA').attr('href', modifySrc)
        $('.delete').attr('href', deleteSrc)
    });

    // 判断进行修改操作是否有选择项
    $('.modifyBtn').click(function() {
        if (!($('.table tr').hasClass('highlight'))) {
            console.log('light')
            alert('至少选择一项修改哦')
            // 关闭模态框
            $('#myModal2').modal('hide')
            return false;
        }
    })

    // 判断进行删除操作是否有选择项
    $('.deleteBtn').click(function() {
        if (!($('.table tr').hasClass('highlight'))) {
            console.log('light')
            alert('至少选择一项删除哦')
            return false
        } else {
            console.log('aa')
            // 获取高亮项 id
            let id = $('.highlight').find('.user-info').text();
            console.log(id)
            let confirm = window.confirm('确认要删除 id 为【' + id + '】这项数据吗？')
            if(!confirm) {
                return false
            }
        }
    })
</script>