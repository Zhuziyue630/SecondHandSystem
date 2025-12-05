package com.secondhand.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    private static String url;
    private static String username;
    private static String password;

    static {
        try {
            // 加载配置文件
            InputStream is = DBUtil.class.getClassLoader()
                    .getResourceAsStream("database.properties");

            if (is == null) {
                System.err.println("❌ 错误：找不到database.properties文件");
                throw new RuntimeException("database.properties文件不存在");
            }

            Properties props = new Properties();
            props.load(is);
            is.close();

            // 获取配置
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            String driver = props.getProperty("db.driver");

            System.out.println("📊 数据库配置：");
            System.out.println("   URL: " + url);
            System.out.println("   用户: " + username);
            System.out.println("   密码: " + (password != null ? "******" : "null"));
            System.out.println("   驱动: " + driver);

            // 加载驱动
            Class.forName(driver);
            System.out.println("✅ 数据库驱动加载成功");

        } catch (Exception e) {
            System.err.println("❌ 数据库配置初始化失败");
            e.printStackTrace();
            throw new RuntimeException("数据库初始化失败", e);
        }
    }

    public static Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            System.out.println("🔗 数据库连接创建成功");
            return conn;
        } catch (SQLException e) {
            System.err.println("❌ 数据库连接失败");
            System.err.println("   错误信息: " + e.getMessage());
            System.err.println("   错误码: " + e.getErrorCode());
            System.err.println("   SQL状态: " + e.getSQLState());
            e.printStackTrace();
            return null;
        }
    }
}