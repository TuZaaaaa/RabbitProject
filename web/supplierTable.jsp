<%@ page import="org.rabbit.vo.Supplier" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/11/30
  Time: 20:22
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
    List<Supplier> supplierList = (List<Supplier>) session.getAttribute("supplierList");
    // 1.定义总记录数
    int totalRows = supplierList.size();

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
    <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">添加供应商</button>
    <button style="display:none" type="button" class="btn btn-outline-info modify" data-bs-toggle="modal" data-bs-target="#myModal2" >修改供应商</button>
    <button type="button" class="btn btn-outline-info modifyBtn"><a class="modifyA" href="supplierService?action=modify&supplierId=">修改供应商</a></button>
    <button style="display: none" type="button" class="btn btn-outline-info detail" data-bs-toggle="modal" data-bs-target="#myModal3"><a>供应商信息</a></button>
    <button type="button" class="btn btn-outline-danger deleteBtn"><a class="delete" href="supplierService?action=delete&supplierId=">删除供应商</a></button>
    <div class="table-wrapper">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>供应商 id</th>
                <th>供应商名称</th>
                <th>供应商地址</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = start;i < start + pageSize;i++) {
                    if (i == supplierList.size()) {
                        break;
                    }

                    Supplier supplier = supplierList.get(i);
            %>
            <tr class="content">
                <td><a class="supplier-info" href="supplierService?action=detail&supplierId=<%=supplier.getSupplierId()%>"><%=supplier.getSupplierId()%></a></td>
                <td><%=supplier.getSupplierName()%></td>
                <td><%=supplier.getSupplierAddress()%></td>
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
                <h4 class="modal-title">添加供应商</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/supplierService?action=add" method="post">
                <div class="modal-body">
                    <label for="supplier-id">供应商id:</label>
                    <input type="text" id="supplier-id" name="supplier-id" class="input-group" value="<%=supplierList.size() + 1000%>">
                    <label for="supplier-name">供应商名称:</label>
                    <input type="text" id="supplier-name" name="supplier-name" class="input-group">
                    <label for="supplier-address">供应商地址:</label>
                    <input type="text" id="supplier-address" name="supplier-address" class="input-group">
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
                <h4 class="modal-title">修改供应商</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/supplierService?action=update" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行修改操作
                        Supplier supplier = (Supplier) session.getAttribute("supplier-modify");
                        if(supplier != null) {
                            int supplierId = supplier.getSupplierId();
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.table tr').eq(<%=supplierId%>).trigger('click')
                        $('.modify').trigger('click')
                    </script>

                    <label for="supplier-id2">供应商id:</label>
                    <input type="text" id="supplier-id2" name="supplier-id2" class="input-group" value="<%=supplier.getSupplierId()%>">
                    <label for="supplier-name2">供应商名称:</label>
                    <input type="text" id="supplier-name2" name="supplier-name2" class="input-group" value="<%=supplier.getSupplierName()%>">
                    <label for="supplier-address2">供应商地址:</label>
                    <input type="text" id="supplier-address2" name="supplier-address2" class="input-group" value="<%=supplier.getSupplierAddress()%>">

                    <%
                            // 用完之后移除
                            session.removeAttribute("supplier-modify");
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
                <h4 class="modal-title">供应商信息</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/supplierService?action=add" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行展示详细信息操作
                        Supplier supplier1 = (Supplier) session.getAttribute("supplier-detail");
                        if (supplier1 != null) {
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.detail').trigger('click')
                    </script>
                    <table class="detail-table" cellspacing="10px">
                        <tr>
                            <td>供应商 id：</td>
                            <td><%=supplier1.getSupplierId()%></td>
                        </tr>
                        <tr>
                            <td>供应商名称：</td>
                            <td><%=supplier1.getSupplierName()%></td>
                        </tr>
                        <tr>
                            <td>供应商地址：</td>
                            <td><%=supplier1.getSupplierAddress()%></td>
                        </tr>
                    </table>
                    <%
                            session.removeAttribute("supplier-detail");
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
        let id = $(this).find('.supplier-info').text()
        let modifySrc = 'supplierService?action=modify&supplierId=' + id
        let deleteSrc = 'supplierService?action=delete&supplierId=' + id
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
            let id = $('.highlight').find('.supplier-info').text();
            console.log(id)
            let confirm = window.confirm('确认要删除 id 为【' + id + '】这项数据吗？')
            if(!confirm) {
                return false
            }
        }
    })
</script>