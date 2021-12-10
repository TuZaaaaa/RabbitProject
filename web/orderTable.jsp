<%@ page import="org.rabbit.vo.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.rabbit.dao.FlowerDao" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/12/1
  Time: 11:45
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
    List<Order> orderList = (List<Order>) session.getAttribute("orderList");
    // 1.定义总记录数
    int totalRows = orderList.size();

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
    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">添加订单</button>
    <button style="display:none" type="button" class="btn btn-outline-info modify" data-bs-toggle="modal" data-bs-target="#myModal2" >修改订单</button>
    <button type="button" class="btn btn-outline-info modifyBtn"><a class="modifyA" href="orderService?action=modify&orderId=">修改订单</a></button>
    <button style="display: none" type="button" class="btn btn-outline-info detail" data-bs-toggle="modal" data-bs-target="#myModal3"><a>订单信息</a></button>
    <button type="button" class="btn btn-outline-danger deleteBtn"><a class="delete" href="orderService?action=delete&orderId=">删除订单</a></button>
    <div class="table-wrapper">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>订单 id</th>
                <th>鲜花名称</th>
                <th>地址</th>
                <th>备注</th>
                <th>时间</th>
                <th>状态</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = start;i < start + pageSize;i++) {
                    if (i == orderList.size()) {
                        break;
                    }

                    Order order = orderList.get(i);
            %>
            <tr class="content">
                <td><a class="order-info" href="orderService?action=detail&orderId=<%=order.getOrderId()%>"><%=order.getOrderId()%></a></td>
                <td><%=new FlowerDao().flowerQueryOne(order.getFlowerId()).getFlowerName()%></td>
                <td><%=order.getOrderAddress()%></td>
                <td><%=order.getOrderDepict()%></td>
                <td><%=order.getOrderTime()%></td>
                <td><%="0".equals(String.valueOf(order.getOrderFlag()))?"未完成":"已完成"%></td>
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
                <h4 class="modal-title">添加订单</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/orderService?action=add" method="post">
                <div class="modal-body">
                    <label for="order-id">订单id:</label>
                    <input type="text" id="order-id" name="order-id" class="input-group" value="<%=orderList.size() + 1000%>">
                    <label for="flower-id">鲜花id:</label>
                    <input type="text" id="flower-id" name="flower-id" class="input-group">
                    <label for="order-address">地址:</label>
                    <input type="text" id="order-address" name="order-address" class="input-group">
                    <label for="order-depict">备注:</label>
                    <input type="text" id="order-depict" name="order-depict" class="input-group">
                    <label for="order-time">时间:</label>
                    <input type="text" id="order-time" name="order-time" class="input-group" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
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
                <h4 class="modal-title">修改订单</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/orderService?action=update" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行修改操作
                        Order order = (Order) session.getAttribute("order-modify");
                        if(order != null) {
                            Integer orderId = order.getOrderId();
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.table tr').eq(<%=orderId%>).trigger('click')
                        $('.modify').trigger('click')
                    </script>

                    <label for="order-id2">订单 id：</label>
                    <input type="text" id="order-id2" name="order-id" class="input-group" value="<%=order.getOrderId()%>">
                    <label for="flower-id2">鲜花名称：</label>
                    <input type="text" id="flower-id2" name="flower-id" class="input-group" value="<%=new FlowerDao().flowerQueryOne(order.getFlowerId()).getFlowerName()%>">
                    <label for="order-address2">地址：</label>
                    <input type="text" id="order-address2" name="order-address" class="input-group" value="<%=order.getOrderAddress()%>">
                    <label for="order-depict2">备注：</label>
                    <input type="text" id="order-depict2" name="order-depict" class="input-group" value="<%=order.getOrderDepict()%>">
                    <label for="order-flag2">状态：</label>
                    <select class="form-select-button input-group orderSelect" name="order-flag2" id="order-flag2">
                        <option value="0">未完成</option>
                        <option value="1">已完成</option>
                    </select>
                    <script>
                        <%
                            int orderFlag = order.getOrderFlag();
                        %>
                        document.querySelector('.orderSelect').options[<%=orderFlag%>].selected = true;
                    </script>
                    <%
                            // 用完之后移除
                            session.removeAttribute("order-modify");
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
            <form action="${pageContext.request.contextPath}/orderService?action=add" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行展示详细信息操作
                        Order order1 = (Order) session.getAttribute("order-detail");
                        if (order1 != null) {
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.detail').trigger('click')
                    </script>
                    <table class="detail-table" cellspacing="10px">
                        <tr>
                            <td>订单 id：</td>
                            <td><%=order1.getOrderId()%></td>
                        </tr>
                        <tr>
                            <td>鲜花名称：</td>
                            <td><%=order1.getFlowerId()%></td>
                        </tr>
                        <tr>
                            <td>地址：</td>
                            <td><%=order1.getOrderAddress()%></td>
                        </tr>
                        <tr>
                            <td>时间：</td>
                            <td><%=order1.getOrderTime()%></td>
                        </tr>
                        <tr>
                            <td>状态：</td>
                            <td><%="0".equals(String.valueOf(order1.getOrderFlag()))?"未完成":"已完成"%></td>
                        </tr>
                    </table>
                    <%
                            session.removeAttribute("order-detail");
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
        let selected = $(this).hasClass("highlight")
        $(".table .content").removeClass("highlight")
        if (!selected) {
            $(this).addClass("highlight")
        }
        // 选中表格项的同时，为 修改和删除按钮的 的 href 赋值
        let id = $(this).find('.order-info').text()
        let modifySrc = 'orderService?action=modify&orderId=' + id
        let deleteSrc = 'orderService?action=delete&orderId=' + id
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
            return false
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
            let id = $('.highlight').find('.order-info').text()
            console.log(id)
            let confirm = window.confirm('确认要删除 id 为【' + id + '】这项数据吗？')
            if(!confirm) {
                return false
            }
        }
    })
</script>