<%@ page import="org.rabbit.vo.Flower" %>
<%@ page import="java.util.List" %>
<%@ page import="org.rabbit.dao.FlowerTypeDao" %>
<%@ page import="org.rabbit.dao.SupplierDao" %><%--
  Created by IntelliJ IDEA.
  User: Rabbit
  Date: 2021/12/2
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
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
        margin-top: 140px;
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

    .first-group > * {
        margin: 0 10px;
    }

    .input-name {
        width: 10px!important;
    }

    td {
        vertical-align: middle;
    }
</style>
<body>
<%
    List<Flower> flowerList = (List<Flower>) session.getAttribute("flowerList");
    // 1.定义总记录数
    int totalRows = flowerList.size();

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
    <div class="table-wrapper">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>鲜花 id</th>
                <th>鲜花名称</th>
                <th>鲜花类型</th>
                <th>鲜花价格</th>
                <th>鲜花库存</th>
                <th>鲜花售出</th>
                <th>供应商</th>
                <th>购买</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (totalRows == 0) {

            %>
            <td  colspan="7">
                当前搜索结果无数据
            </td>
            <%
                    return;
                }
            %>
            <%
                for (int i = start;i < start + pageSize;i++) {
                    if (i == flowerList.size()) {
                        break;
                    }
                    Flower flower = flowerList.get(i);
            %>
            <tr class="content">
                <td><a class="flower-info" href="flowerService?action=detail&flowerId=<%=flower.getFlowerId()%>"><%=flower.getFlowerId()%></a></td>
                <td><%=flower.getFlowerName()%></td>
                <td>
                    <%=new FlowerTypeDao().flowerTypeQueryOne(flower.getTypeId()).getTypeName()%>
                </td>
                <td><%=flower.getFlowerPrice()%></td>
                <td><%=flower.getFlowerStock()%></td>
                <td><%=flower.getFlowerSell()%></td>
                <td>
                    <%=new SupplierDao().supplierQueryOne(flower.getSupplierId()).getSupplierName()%>
                </td>
                <td>
                    <form class="buyBtn" action="#">
                        <button type="submit" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">购买</button>
                    </form>
                </td>
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

<div class="modal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">购买鲜花</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form class="buyForm" action="${pageContext.request.contextPath}/flowerService?action=buy&flowerId=" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行展示详细信息操作
                        Flower flower1 = (Flower) session.getAttribute("flower-info-buy");
                        if (flower1 != null) {
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.detail').trigger('click')
                    </script>
                    <table class="detail-table" cellspacing="10px">
                        <tr>
                            <td>鲜花 id：</td>
                            <td><%=flower1.getFlowerId()%></td>
                        </tr>
                        <tr>
                            <td>鲜花名称：</td>
                            <td><%=flower1.getFlowerName()%></td>
                        </tr>
                        <tr>
                            <td>鲜花类型：</td>
                            <td><%=new FlowerTypeDao().flowerTypeQueryOne(flower1.getTypeId()).getTypeName()%></td>
                        </tr>
                        <tr>
                            <td>鲜花价格：</td>
                            <td><%=flower1.getFlowerPrice()%></td>
                        </tr>
                        <tr>
                            <td>鲜花库存：</td>
                            <td><%=flower1.getFlowerStock()%></td>
                        </tr>
                        <tr>
                            <td>鲜花售出：</td>
                            <td><%=flower1.getFlowerSell()%></td>
                        </tr>
                        <tr>
                            <td>供应商 id：</td>
                            <td><%=new SupplierDao().supplierQueryOne(flower1.getSupplierId()).getSupplierName()%></td>
                        </tr>
                    </table>
                    <%
                            session.removeAttribute("flower-info-buy");
                        }
                    %>
                </div>

                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success" data-bs-dismiss="modal">下单</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
<script>
    // 为表格内容添加点击事件（高亮显示）
    $(".buy").click(function() {
        // 选中表格项的同时，为 修改和删除按钮的 的 href 赋值
        let id = $(this).find('.flower-info').text()
        let formAction = 'flowerService?action=buy&flowerId=' + id
        $('.modifyA').attr('action', formAction)
    });

    $(".table .content").click(function() {
        let selected = $(this).hasClass("highlight");
        $(".table .content").removeClass("highlight");
        if (!selected) {
            $(this).addClass("highlight");
        }
        // 选中表格项的同时，为 修改和删除按钮的 的 href 赋值
        let id = $(this).find('.flower-info').text()
        let formAction = 'flowerService?action=buy&flowerId=' + id
        let buySrc = '${pageContext.request.contextPath}flowerService?action=shopDetail&flowerId=' + id
        $('.buyForm').attr('action', formAction)
        $('.buyBtn').attr('action', buySrc)
    });
</script>