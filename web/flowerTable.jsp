<%@ page import="org.rabbit.vo.Flower" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
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

    a {
        text-decoration: none!important;
    }

    .highlight {
        background-color: #cbc0d3!important;
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
    String sql = "select * from tb_flower order by goodsID limit "+ start +", " + pageSize;
%>
    <div class="box">
        <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">添加鲜花</button>
        <button type="button" class="btn btn-outline-info"><a href="">修改鲜花</a></button>
        <button type="button" class="btn btn-outline-danger">删除鲜花</button>
        <div class="table-wrapper">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>鲜花 id</th>
                    <th>鲜花名称</th>
                    <th>鲜花类型 id</th>
                    <th>鲜花价格</th>
                    <th>鲜花库存</th>
                    <th>鲜花售出</th>
                    <th>供应商 id</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (int i = start;i < start + pageSize;i++) {
                        if (i == flowerList.size()) {
                            break;
                        }
                        Flower flower = flowerList.get(i);
                %>
                <tr>
                    <td><a href="flowerService?action=details&flowerId=<%=flower.getFlowerId()%>"><%=flower.getFlowerId()%></a></td>
                    <td><%=flower.getFlowerName()%></td>
                    <td><%=flower.getTypeId()%></td>
                    <td><%=flower.getFlowerPrice()%></td>
                    <td><%=flower.getFlowerStock()%></td>
                    <td><%=flower.getFlowerSell()%></td>
                    <td><%=flower.getSupplierId()%></td>
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
                    <h4 class="modal-title">添加鲜花</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- 模态框内容 -->
                <form action="${pageContext.request.contextPath}/flowerService?action=add" method="post">
                    <div class="modal-body">
                        <label for="flower-id">鲜花id:</label>
                        <input type="text" id="flower-id" name="flower-id" class="input-group">
                        <label for="flower-name">鲜花名称:</label>
                        <input type="text" id="flower-name" name="flower-name" class="input-group">
                        <label for="flower-type">鲜花类型id:</label>
                        <input type="text" id="flower-type" name="flower-type" class="input-group">
                        <label for="flower-price">鲜花价格:</label>
                        <input type="text" id="flower-price" name="flower-price" class="input-group">
                        <label for="flower-stock">鲜花库存:</label>
                        <input type="text" id="flower-stock" name="flower-stock" class="input-group">
                        <label for="flower-sell">鲜花售出:</label>
                        <input type="text" id="flower-sell" name="flower-sell" class="input-group">
                        <label for="flower-supplier-id">供应商id:</label>
                        <input type="text" id="flower-supplier-id" name="flower-supplier-id" class="input-group">
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
</body>
</html>

<script src="static/js/jquery-3.6.0.js"></script>
<script>
    $(".table tr").click(function() {
        let selected = $(this).hasClass("highlight");
        $(".table tr").removeClass("highlight");
        if (!selected)
            $(this).addClass("highlight");
    });
</script>