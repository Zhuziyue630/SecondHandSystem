<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="header">
    <div class="container">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/" class="logo">二手信息发布系统</a>
            <div class="nav-links">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span style="color: white;">欢迎，${sessionScope.user.username}</span>
                        <a href="${pageContext.request.contextPath}/item/list">物品列表</a>
                        <a href="${pageContext.request.contextPath}/item/mylist">我的发布</a>
                        <a href="${pageContext.request.contextPath}/item/add">发布物品</a>
                        <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/item/list">物品列表</a>
                        <a href="${pageContext.request.contextPath}/user/login">登录</a>
                        <a href="${pageContext.request.contextPath}/user/register">注册</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <div class="hero-section" style="text-align: center; padding: 60px 0;">
        <h1 style="font-size: 2.5rem; margin-bottom: 20px;">欢迎使用二手信息发布系统</h1>
        <p style="font-size: 1.2rem; color: #666; margin-bottom: 30px;">
            捡到丢失物品？寻找失物？这里可以帮您！
        </p>

        <c:if test="${not empty sessionScope.user}">
            <div style="margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/item/add" class="btn btn-success" style="padding: 15px 30px; font-size: 1.1rem;">
                    发布物品信息
                </a>
            </div>
        </c:if>

        <c:if test="${empty sessionScope.user}">
            <div style="margin-top: 30px;">
                <a href="${pageContext.request.contextPath}/user/login" class="btn" style="padding: 15px 30px; font-size: 1.1rem; margin-right: 15px;">
                    立即登录
                </a>
                <a href="${pageContext.request.contextPath}/user/register" class="btn btn-success" style="padding: 15px 30px; font-size: 1.1rem;">
                    注册新用户
                </a>
            </div>
        </c:if>
    </div>

    <div class="features" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 50px;">
        <div class="feature-card" style="background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #2c3e50; margin-bottom: 15px;">捡到物品</h3>
            <p>捡到他人丢失的物品？可以在这里发布信息，帮助失主找回。</p>
        </div>

        <div class="feature-card" style="background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #2c3e50; margin-bottom: 15px;">寻找失物</h3>
            <p>丢失了物品？可以在这里查找是否有人捡到，实现模糊匹配搜索。</p>
        </div>

        <div class="feature-card" style="background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #2c3e50; margin-bottom: 15px;">安全可靠</h3>
            <p>用户账号加密存储，信息安全有保障，修改删除方便快捷。</p>
        </div>
    </div>
</main>

<footer style="background-color: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 50px;">
    <div class="container">
        <p>&copy; 2024 二手信息发布系统 - 课程设计项目</p>
    </div>
</footer>
</body>
</html>