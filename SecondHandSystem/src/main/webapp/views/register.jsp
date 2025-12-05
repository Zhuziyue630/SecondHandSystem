<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册 - 二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="header">
    <div class="container">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/" class="logo">二手信息发布系统</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/">首页</a>
                <a href="${pageContext.request.contextPath}/item/list">物品列表</a>
                <a href="${pageContext.request.contextPath}/user/login">登录</a>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <div class="form-container">
        <h2 style="text-align: center; margin-bottom: 30px; color: #2c3e50;">用户注册</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                    ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div class="form-group">
                <label for="username">用户名 *</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="password">密码 *</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email" class="form-control">
            </div>

            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="tel" id="phone" name="phone" class="form-control">
            </div>

            <div class="form-group" style="text-align: center;">
                <button type="submit" class="btn btn-success" style="width: 100%; padding: 12px;">注册</button>
            </div>

            <div style="text-align: center; margin-top: 20px;">
                <p>已有账号？ <a href="${pageContext.request.contextPath}/user/login">立即登录</a></p>
            </div>
        </form>
    </div>
</main>
</body>
</html>