<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>发布物品 - 二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script>
        function setToday() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('foundLostDate').value = today;
        }

        function validateForm() {
            const title = document.getElementById('title').value;
            const description = document.getElementById('description').value;
            const location = document.getElementById('location').value;
            const date = document.getElementById('foundLostDate').value;

            if (!title.trim()) {
                alert('请输入物品标题');
                return false;
            }
            if (!description.trim()) {
                alert('请输入物品描述');
                return false;
            }
            if (!location.trim()) {
                alert('请输入地点');
                return false;
            }
            if (!date) {
                alert('请选择日期');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<header class="header">
    <div class="container">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/" class="logo">二手信息发布系统</a>
            <div class="nav-links">
                <span style="color: white;">${sessionScope.user.username}</span>
                <a href="${pageContext.request.contextPath}/">首页</a>
                <a href="${pageContext.request.contextPath}/item/list">物品列表</a>
                <a href="${pageContext.request.contextPath}/item/mylist">我的发布</a>
                <a href="${pageContext.request.contextPath}/user/logout">退出</a>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <div class="form-container">
        <h2 style="text-align: center; margin-bottom: 30px; color: #2c3e50;">发布物品信息</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/item/add" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="itemType">物品类型 *</label>
                <select id="itemType" name="itemType" class="form-control" required>
                    <option value="">请选择类型</option>
                    <option value="1">捡到物品</option>
                    <option value="2">丢失物品</option>
                </select>
            </div>

            <div class="form-group">
                <label for="title">物品标题 *</label>
                <input type="text" id="title" name="title" class="form-control"
                       placeholder="例如：捡到黑色钱包、丢失手机" required>
            </div>

            <div class="form-group">
                <label for="description">详细描述 *</label>
                <textarea id="description" name="description" class="form-control"
                          rows="4" placeholder="请详细描述物品特征、外观、内含物品等信息..." required></textarea>
            </div>

            <div class="form-group">
                <label for="location">地点 *</label>
                <input type="text" id="location" name="location" class="form-control"
                       placeholder="例如：图书馆三楼、食堂一楼" required>
            </div>

            <div class="form-group">
                <label for="foundLostDate">发现/丢失日期 *</label>
                <div style="display: flex; gap: 10px;">
                    <input type="date" id="foundLostDate" name="foundLostDate"
                           class="form-control" required>
                    <button type="button" class="btn" onclick="setToday()" style="white-space: nowrap;">今天</button>
                </div>
            </div>

            <div class="form-group">
                <label for="imageUrl">图片URL（可选）</label>
                <input type="url" id="imageUrl" name="imageUrl" class="form-control"
                       placeholder="请输入图片的URL地址（可选）">
                <small style="color: #666;">如果不提供图片URL，将使用默认图片</small>
            </div>

            <div class="form-group" style="text-align: center;">
                <button type="submit" class="btn btn-success" style="width: 100%; padding: 12px;">发布物品</button>
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/item/mylist" class="btn">返回我的发布</a>
            </div>
        </form>
    </div>
</main>
</body>
</html>