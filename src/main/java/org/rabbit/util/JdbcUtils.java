package org.rabbit.util;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * @author Rabbit
 */
public class JdbcUtils {
    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws Exception{

        InputStream is = ClassLoader.getSystemClassLoader().getResourceAsStream("jdbc.properties");

        Properties properties = new Properties();
        properties.load(is);

        String user = properties.getProperty("user");
        String password = properties.getProperty("password");
        String url = properties.getProperty("url");
        String driverClass = properties.getProperty("driverClass");

        Class.forName(driverClass);

        return DriverManager.getConnection(url, user, password);
    }

    /**
     *关闭数据库连接
     */
    public static void closeConnection(Connection conn, PreparedStatement ps) {
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException throwable) {
                throwable.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException throwable) {
                throwable.printStackTrace();
            }
        }
    }

    /**
     * 关闭数据库连接（含结果集）
     */
    public static void closeConnection(Connection conn, PreparedStatement ps, ResultSet rs) {
        closeConnection(conn, ps);
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException throwable) {
                throwable.printStackTrace();
            }
        }
    }
}