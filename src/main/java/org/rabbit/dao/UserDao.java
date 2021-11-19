package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Rabbit
 */
public class UserDao {

    /**
     * 处理登录操作 登录验证
     */
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    String sql = null;

    public User login(User user) {
        try{
            // 判断连接是否存在
            if (connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            sql = "select * from db_user where user_name = ? and user_password = ? and user_flag = ?";
            System.out.println(sql);
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getUserPassword());
            preparedStatement.setString(3, user.getUserFlag());
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                System.out.println("登录成功");
            } else {
                System.out.println("登录失败");
                user = null;
            }
        } catch (SQLException e) {
            user = null;
            e.printStackTrace();
        } finally {
            // 关闭连接
            MySqlConnection.closeConnection();
        }
        return user;
    }
}