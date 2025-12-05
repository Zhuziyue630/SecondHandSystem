package com.secondhand.test;

import com.secondhand.util.DBUtil;
import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        System.out.println("开始测试数据库连接...");

        try {
            Connection conn = DBUtil.getConnection();
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ 数据库连接成功！");
                System.out.println("✅ 连接URL: " + conn.getMetaData().getURL());
                conn.close();
            } else {
                System.out.println("❌ 数据库连接失败！");
            }
        } catch (Exception e) {
            System.out.println("❌ 连接异常：" + e.getMessage());
            e.printStackTrace();
        }
    }
}