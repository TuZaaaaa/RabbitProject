<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
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
</style>
<!-- 新 Bootstrap5 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/css/bootstrap.min.css">

<!-- 最新的 Bootstrap5 核心 JavaScript 文件 -->
<script src="https://cdn.staticfile.org/twitter-bootstrap/5.1.1/js/bootstrap.bundle.min.js"></script>
<body>
    <div class="box">
        <button type="button" class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">添加鲜花</button>
        <button type="button" class="btn btn-outline-info">修改鲜花</button>
        <button type="button" class="btn btn-outline-danger">删除鲜花</button>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>鲜花 id</th>
                <th>鲜花名称</th>
                <th>鲜花类型</th>
                <th>鲜花价格</th>
                <th>鲜花库存</th>
                <th>鲜花售出</th>
                <th>供应商名称</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1000</td>
                <td>Doe</td>
                <td>john@example.com</td>
                <td>1000</td>
                <td>Doe</td>
                <td>john@example.com</td>
                <td>john@example.com</td>
            </tr>
            </tbody>
        </table>
    </div>


    <!-- 模态框 -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- 模态框头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">模态框标题</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- 模态框内容 -->
                <div class="modal-body">
                    <form action="">
                        <label for="flower-id">鲜花id:</label>
                        <input type="text" id="flower-id" class="input-group">
                        <label for="flower-name">鲜花名称:</label>
                        <input type="text" id="flower-name" class="input-group">
                        <label for="flower-type">鲜花类型:</label>
                        <input type="text" id="flower-type" class="input-group">
                        <label for="flower-price">鲜花价格:</label>
                        <input type="text" id="flower-price" class="input-group">
                        <label for="flower-stock">鲜花库存:</label>
                        <input type="text" id="flower-stock" class="input-group">
                        <label for="flower-sell">鲜花售出:</label>
                        <input type="text" id="flower-sell" class="input-group">
                        <label for="flower-supplier">供应商名称:</label>
                        <input type="text" id="flower-supplier" class="input-group">
                    </form>
                </div>

                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">添加</button>
                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">关闭</button>
                </div>

            </div>
        </div>
    </div>
</body>
</html>