# 📋 二手信息发布系统

## 🎯 项目简介
一个基于Java Web的二手信息发布系统，实现了用户注册登录、发布捡到/丢失物品、模糊搜索等核心功能。本项目采用标准的MVC架构，使用Servlet+JSP技术栈。

## ✨ 功能特性
- ✅ **用户注册登录**：密码使用BCrypt加密存储，安全可靠
- ✅ **物品发布**：支持捡到物品和丢失物品两种类型
- ✅ **智能搜索**：支持标题、描述、地点的模糊匹配
- ✅ **权限管理**：用户只能修改和删除自己发布的物品
- ✅ **响应式界面**：适配不同设备的浏览器
- ✅ **数据验证**：前端JavaScript验证和后端Servlet验证

## 🏗️ 系统架构设计

### 1. 技术栈
- **后端框架**：Java Servlet 5.0 + JSP + JSTL
- **数据库**：MySQL 8.0+
- **应用服务器**：Tomcat 11.0
- **构建工具**：Maven 3.6+
- **开发工具**：IntelliJ IDEA
- **密码加密**：BCrypt

### 2. 项目结构（MVC模式）
SecondHandSystem/
├── src/main/java/com/secondhand/
│ ├── entity/ # 实体层（POJO）
│ │ ├── User.java # 用户实体
│ │ └── Item.java # 物品实体
│ ├── dao/ # 数据访问层
│ │ ├── UserDAO.java # 用户数据操作
│ │ └── ItemDAO.java # 物品数据操作
│ ├── service/ # 业务逻辑层
│ │ ├── UserService.java # 用户业务逻辑
│ │ └── ItemService.java # 物品业务逻辑
│ ├── controller/ # 控制层（Servlet）
│ │ ├── UserServlet.java # 用户相关请求处理
│ │ ├── ItemServlet.java # 物品相关请求处理
│ │ ├── EncodingFilter.java # 编码过滤器
│ │ └── AuthFilter.java # 认证过滤器
│ └── util/ # 工具类
│ ├── DBUtil.java # 数据库连接工具
│ └── PasswordUtil.java # 密码加密工具
├── src/main/webapp/ # 视图层
│ ├── css/ # 样式文件
│ │ └── style.css # 主要样式
│ ├── views/ # JSP页面
│ │ ├── login.jsp # 登录页面
│ │ ├── register.jsp # 注册页面
│ │ └── item/ # 物品相关页面
│ │ ├── list.jsp # 物品列表
│ │ ├── mylist.jsp # 我的发布
│ │ ├── add.jsp # 发布物品
│ │ ├── edit.jsp # 编辑物品
│ │ └── detail.jsp # 物品详情
│ └── index.jsp # 首页
└── pom.xml # Maven依赖配置

### 3. 数据流设计
用户请求 → 过滤器(编码/认证) → Servlet控制器 → Service业务层 → DAO数据层 → MySQL数据库

## 📊 数据库结构说明

### 1. 数据库：`secondhand_db`
字符集：utf8mb4，排序规则：utf8mb4_general_ci

### 2. 表结构设计

#### 用户表（users）
```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '加密后的密码',
    email VARCHAR(100) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '手机号',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    is_active TINYINT DEFAULT 1 COMMENT '是否激活(1:是,0:否)'
);

CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL COMMENT '发布用户ID',
    title VARCHAR(100) NOT NULL COMMENT '物品标题',
    description TEXT COMMENT '详细描述',
    item_type TINYINT NOT NULL COMMENT '物品类型(1:捡到物品,2:丢失物品)',
    location VARCHAR(200) COMMENT '发现/丢失地点',
    found_lost_date DATE COMMENT '发现/丢失日期',
    image_url VARCHAR(500) COMMENT '图片URL',
    status TINYINT DEFAULT 1 COMMENT '状态(1:有效,0:删除)',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id)
);
关系说明
一个用户可以发布多个物品（一对多关系）
物品表通过user_id外键关联用户表
物品支持软删除（status=0表示删除）

1. 预置测试账号
用户名: test
密码: test123
邮箱: test@example.com
手机号: 13800138000
