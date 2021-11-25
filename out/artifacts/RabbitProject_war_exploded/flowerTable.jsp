<%@ page import="org.rabbit.vo.Flower" %>
<%@ page import="java.util.List" %>
<%@ page import="org.rabbit.dao.FlowerTypeDao" %>
<%@ page import="org.rabbit.dao.SupplierDao" %>
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

    .modifyB {
        color: #ff0000;
    }

    .modifyB:hover {
        color: #fff;
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
        <button style="display:none" type="button" class="btn btn-outline-info modify" data-bs-toggle="modal" data-bs-target="#myModal2" >修改鲜花</button>
        <button type="button" class="btn btn-outline-info modify"><a class="modifyA" href="flowerService?action=modify&flowerId=">修改鲜花</a></button>
        <button style="display: none" type="button" class="btn btn-outline-info detail" data-bs-toggle="modal" data-bs-target="#myModal3"><a>鲜花信息</a></button>
        <button type="button" class="btn btn-outline-danger delete"><a class="modifyB" href="flowerService?action=delete&flowerId=">删除鲜花</a></button>
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
                        <label for="type-id">鲜花类型id:</label>
                        <input type="text" id="type-id" name="type-id" class="input-group">
                        <label for="flower-price">鲜花价格:</label>
                        <input type="text" id="flower-price" name="flower-price" class="input-group">
                        <label for="flower-stock">鲜花库存:</label>
                        <input type="text" id="flower-stock" name="flower-stock" class="input-group">
                        <label for="flower-sell">鲜花售出:</label>
                        <input type="text" id="flower-sell" name="flower-sell" class="input-group">
                        <label for="supplier-id">供应商id:</label>
                        <input type="text" id="supplier-id" name="supplier-id" class="input-group">
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
                <h4 class="modal-title">修改鲜花</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/flowerService?action=add" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行修改操作
                        Flower flower = (Flower) session.getAttribute("flower-modify");
                        if(flower != null) {
                            Integer flowerId = flower.getFlowerId();
                    %>
                    <script>
                        // 模拟用户操作点击
                        $('.table tr').eq(<%=flowerId%>).trigger('click')
                        $('.modify').trigger('click')
                    </script>
                    <label for="flower-id2">鲜花id：</label>
                    <input type="text" id="flower-id2" name="flower-id" class="input-group" value="<%=flower.getFlowerId()%>">
                    <label for="flower-name2">鲜花名称：</label>
                    <input type="text" id="flower-name2" name="flower-name" class="input-group" value="<%=flower.getFlowerName()%>">
                    <%
                        String typeName = new FlowerTypeDao().flowerTypeQueryOne(flower.getTypeId()).getTypeName();
                    %>
                    <label for="type-id2">鲜花类型id：</label>
                    <input type="text" id="type-id2" name="type-id" class="input-group" value="<%=typeName%>">
                    <label for="flower-price2">鲜花价格：</label>
                    <input type="text" id="flower-price2" name="flower-price" class="input-group" value="<%=flower.getFlowerPrice()%>">
                    <label for="flower-stock2">鲜花库存：</label>
                    <input type="text" id="flower-stock2" name="flower-stock" class="input-group" value="<%=flower.getFlowerStock()%>">
                    <label for="flower-sell2">鲜花售出：</label>
                    <input type="text" id="flower-sell2" name="flower-sell" class="input-group" value="<%=flower.getFlowerSell()%>">
                    <%
                        String supplierName = new SupplierDao().supplierQueryOne(flower.getSupplierId()).getSupplierName();
                    %>
                    <label for="supplier-id2">供应商：</label>
                    <input type="text" id="supplier-id2" name="supplier-id" class="input-group" value="<%=supplierName%>">
                    <%
                            // 用完之后移除
                            session.removeAttribute("flower-modify");
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
                <h4 class="modal-title">鲜花信息</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- 模态框内容 -->
            <form action="${pageContext.request.contextPath}/flowerService?action=add" method="post">
                <div class="modal-body">
                    <%
                        // 判断是否执行展示详细信息操作
                        Flower flower1 = (Flower) session.getAttribute("flower-detail");
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
                            session.removeAttribute("flower-detail");
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
    // 为表格内容添加点击时间（高亮显示）
    $(".table .content").click(function() {
        let selected = $(this).hasClass("highlight");
        $(".table .content").removeClass("highlight");
        if (!selected) {
            $(this).addClass("highlight");
        }
        // 选中表格项的同时，为 修改和删除按钮的 的 href 赋值
        let id = $(this).find('.flower-info').text()
        let src = 'flowerService?action=modify&flowerId=' + id
        console.log(src)
        $('.modifyA').attr('href', src)
        $('.modifyB').attr('href', src)
    });

    // 判断进行修改操作是否有选择项
    $('.modify').click(function() {
        if (!($('.table tr').hasClass('highlight'))) {
            console.log('light')
            alert('至少选择一项修改哦')
            // 关闭模态框
            $('#myModal2').modal('hide')
            return false;
        }
    })

    // 判断进行删除操作是否有选择项
    $('.delete').click(function() {
        if (!($('.table tr').hasClass('highlight'))) {
            console.log('light')
            alert('至少选择一项删除哦')
            return false;
        }
    })
</script>