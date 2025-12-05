<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>物品详情 - 二手信息发布系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header class="header">
    <div class="container">
        <nav class="navbar">
            <a href="${pageContext.request.contextPath}/" class="logo">二手信息发布系统</a>
            <div class="nav-links">
                <c:if test="${not empty sessionScope.user}">
                    <span style="color: white;">${sessionScope.user.username}</span>
                </c:if>
                <a href="${pageContext.request.contextPath}/">首页</a>
                <a href="${pageContext.request.contextPath}/item/list">物品列表</a>
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/item/mylist">我的发布</a>
                    <a href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/user/login">登录</a>
                    <a href="${pageContext.request.contextPath}/user/register">注册</a>
                </c:if>
            </div>
        </nav>
    </div>
</header>

<main class="container">
    <c:if test="${not empty item}">
        <div class="detail-container">
            <div class="detail-header">
                <h2 style="color: #2c3e50;">
                    <c:choose>
                        <c:when test="${item.itemType == 1}">
                            <span style="color: #2ecc71;">[捡到物品]</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: #e74c3c;">[丢失物品]</span>
                        </c:otherwise>
                    </c:choose>
                        ${item.title}
                </h2>

                <c:if test="${sessionScope.userId == item.userId}">
                    <div style="display: flex; gap: 10px;">
                        <a href="${pageContext.request.contextPath}/item/edit?id=${item.id}"
                           class="btn btn-warning">编辑</a>
                        <a href="${pageContext.request.contextPath}/item/delete?id=${item.id}"
                           class="btn btn-danger"
                           onclick="return confirm('确定要删除这个物品吗？')">删除</a>
                    </div>
                </c:if>
            </div>

            <c:if test="${not empty item.imageUrl}">
                <img src="${item.imageUrl}" alt="${item.title}" class="detail-image">
            </c:if>

            <div class="detail-info">
                <div class="info-item">
                    <label>物品类型</label>
                    <span>
                            <c:choose>
                                <c:when test="${item.itemType == 1}">
                                    <strong style="color: #2ecc71;">捡到物品</strong>
                                </c:when>
                                <c:otherwise>
                                    <strong style="color: #e74c3c;">丢失物品</strong>
                                </c:otherwise>
                            </c:choose>
                        </span>
                </div>

                <div class="info-item">
                    <label>地点</label>
                    <span>${item.location}</span>
                </div>

                <div class="info-item">
                    <label>发现/丢失日期</label>
                    <span><fmt:formatDate value="${item.foundLostDate}" pattern="yyyy年MM月dd日"/></span>
                </div>

                <div class="info-item">
                    <label>发布者</label>
                    <span>${item.username}</span>
                </div>

                <div class="info-item">
                    <label>发布时间</label>
                    <span><fmt:formatDate value="${item.createTime}" pattern="yyyy年MM月dd日 HH:mm"/></span>
                </div>

                <div class="info-item">
                    <label>最后更新</label>
                    <span><fmt:formatDate value="${item.updateTime}" pattern="yyyy年MM月dd日 HH:mm"/></span>
                </div>
            </div>

            <div style="margin-top: 30px;">
                <h3 style="color: #2c3e50; margin-bottom: 15px;">物品描述</h3>
                <div style="background: #f8f9fa; padding: 20px; border-radius: 4px; line-height: 1.8;">
                        ${item.description}
                </div>
            </div>

            <div style="margin-top: 30px; text-align: center;">
                <a href="${pageContext.request.contextPath}/item/list" class="btn">返回物品列表</a>
                <c:if test="${sessionScope.userId == item.userId}">
                    <a href="${pageContext.request.contextPath}/item/mylist" class="btn btn-warning">返回我的发布</a>
                </c:if>
            </div>
        </div>
    </c:if>

    <c:if test="${empty item}">
        <div style="text-align: center; padding: 50px; background: white; border-radius: 8px;">
            <h3 style="color: #666;">物品不存在或已被删除</h3>
            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/item/list" class="btn">返回物品列表</a>
            </div>
        </div>
    </c:if>
</main>

<footer style="background-color: #2c3e50; color: white; text-align: center; padding: 20px; margin-top: 50px;">
    <div class="container">
        <p>&copy; 2024 二手信息发布系统 - 课程设计项目</p>
    </div>
</footer>
</body>
</html>