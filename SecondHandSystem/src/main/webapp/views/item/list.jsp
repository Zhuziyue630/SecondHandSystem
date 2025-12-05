<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>物品列表 - 二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="header">
    <div class="container">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/" class="logo">二手信息发布系统</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/">首页</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span style="color: white;">${sessionScope.user.username}</span>
                        <a href="${pageContext.request.contextPath}/item/mylist">我的发布</a>
                        <a href="${pageContext.request.contextPath}/item/add">发布物品</a>
                        <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/login">登录</a>
                        <a href="${pageContext.request.contextPath}/user/register">注册</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/item/search" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="搜索物品名称、描述或地点..."
                   value="${param.keyword}" style="flex: 1;">
            <select name="itemType">
                <option value="">全部类型</option>
                <option value="1" ${param.itemType == '1' ? 'selected' : ''}>捡到物品</option>
                <option value="2" ${param.itemType == '2' ? 'selected' : ''}>丢失物品</option>
            </select>
            <button type="submit" class="btn">搜索</button>
            <a href="${pageContext.request.contextPath}/item/list" class="btn btn-warning">重置</a>
        </form>
    </div>

    <c:if test="${not empty items}">
        <div class="card-container">
            <c:forEach var="item" items="${items}">
                <div class="card">
                    <c:if test="${not empty item.imageUrl}">
                        <img src="${item.imageUrl}" alt="${item.title}" class="card-img">
                    </c:if>
                    <div class="card-body">
                        <h3 class="card-title">
                            <c:choose>
                                <c:when test="${item.itemType == 1}">
                                    <span style="color: #2ecc71;">[捡到]</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #e74c3c;">[丢失]</span>
                                </c:otherwise>
                            </c:choose>
                                ${item.title}
                        </h3>
                        <p class="card-text">${item.description}</p>
                        <div class="card-info">
                            <span>地点：${item.location}</span>
                            <span>日期：<fmt:formatDate value="${item.foundLostDate}" pattern="yyyy-MM-dd"/></span>
                        </div>
                        <div class="card-info" style="margin-top: 10px;">
                            <span>发布者：${item.username}</span>
                            <span>时间：<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                        <div style="margin-top: 15px;">
                            <a href="${pageContext.request.contextPath}/item/detail?id=${item.id}" class="btn">查看详情</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty items}">
        <div style="text-align: center; padding: 50px; background: white; border-radius: 8px;">
            <h3 style="color: #666;">暂无物品信息</h3>
            <c:if test="${not empty sessionScope.user}">
                <p style="margin: 20px 0;">
                    <a href="${pageContext.request.contextPath}/item/add" class="btn btn-success">发布第一个物品</a>
                </p>
            </c:if>
        </div>
    </c:if>
</main>
</body>
</html>