package org.rabbit;

import org.junit.Test;
import org.rabbit.util.JdbcUtils;

import java.sql.Connection;

public class JdbcTest {
    @Test
    public void testJdbc() throws Exception {
        Connection connection = JdbcUtils.getConnection();
        System.out.println(connection);
    }
}