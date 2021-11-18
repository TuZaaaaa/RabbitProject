package org.rabbit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author Rabbit
 */
public class MySqlConnection {

    private static String ClassName = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3306/db_bloom?useUnicode=true&&characterEncoding=utf-8";
    private static String user = "root";
    private static String pwd = "root";
    private static Connection conn = null;

    /**
     * 获取数据库连接
     * @return 返回 Connection 对象
     */
    public static Connection getConnection() {
        // 1.加载驱动程序
        try {
            Class.forName(ClassName);
            conn = DriverManager.getConnection(url, user, pwd);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return conn;
    }

    public static void closeConnection() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}