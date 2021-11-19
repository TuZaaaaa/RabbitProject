package org.rabbit;

import org.junit.Test;
import org.rabbit.util.JdbcUtils;
import org.rabbit.util.MySqlConnection;

import java.sql.Connection;

public class JdbcTest {
    @Test
    public void testJdbc() throws Exception {
        Connection connection = JdbcUtils.getConnection();
        Connection connection1 = MySqlConnection.getConnection();
        System.out.println(connection);
        System.out.println(connection1);
    }
}