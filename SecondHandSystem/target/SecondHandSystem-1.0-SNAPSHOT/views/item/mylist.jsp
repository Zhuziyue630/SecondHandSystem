<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的发布 - 二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                <a href="${pageContext.request.contextPath}/item/add">发布物品</a>
                <a href="${pageContext.request.contextPath}/user/logout">退出</a>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="color: #2c3e50;">我的发布</h2>
        <a href="${pageContext.request.contextPath}/item/add" class="btn btn-success">发布新物品</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
                ${error}
        </div>
    </c:if>

    <c:if test="${not empty items}">
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>类型</th>
                    <th>标题</th>
                    <th>地点</th>
                    <th>日期</th>
                    <th>发布时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${items}">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${item.itemType == 1}">
                                    <span style="color: #2ecc71; font-weight: bold;">捡到物品</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #e74c3c; font-weight: bold;">丢失物品</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${item.title}</td>
                        <td>${item.location}</td>
                        <td><fmt:formatDate value="${item.foundLostDate}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/item/detail?id=${item.id}" class="btn">查看</a>
                                <a href="${pageContext.request.contextPath}/item/edit?id=${item.id}" class="btn btn-warning">编辑</a>
                                <a href="${pageContext.request.contextPath}/item/delete?id=${item.id}"
                                   class="btn btn-danger"
                                   onclick="return confirm('确定要删除这个物品吗？')">删除</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>

    <c:if test="${empty items}">
        <div style="text-align: center; padding: 50px; background: white; border-radius: 8px; margin-top: 20px;">
            <h3 style="color: #666;">您还没有发布任何物品</h3>
            <p style="margin: 20px 0;">快去发布第一个物品吧！</p>
            <a href="${pageContext.request.contextPath}/item/add" class="btn btn-success">发布物品</a>
        </div>
    </c:if>
</main>
</body>
</html>