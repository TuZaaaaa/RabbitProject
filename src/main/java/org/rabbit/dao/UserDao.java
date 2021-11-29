package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.FlowerType;
import org.rabbit.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
            sql = "select * from tb_user where user_name = ? and user_password = ? and user_flag = ?";
            System.out.println(sql);
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getUserPassword());
            preparedStatement.setInt(3, user.getUserFlag());
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

    /**
     * 添加用户信息
     * @param user 鲜花类型实体类对象
     * @return int 1:成功 0:失败 -1:异常
     */
    public int userAdd(User user) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "insert into tb_user values(?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, user.getUserId());
            preparedStatement.setString(2, user.getUserName());
            preparedStatement.setString(3, user.getUserPassword());
            preparedStatement.setString(4, user.getUserTelephone());
            preparedStatement.setString(5, user.getUserEmail());
            preparedStatement.setString(6, user.getUserAddress());
            preparedStatement.setInt(7, user.getUserFlag());
            //3. 执行语句
            rel = preparedStatement.executeUpdate();
            //4. 处理执行结果
        } catch(SQLException e) {
            rel = -1;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return rel;
    }

    /**
     * 根据 id 删除指定用户信息
     * @param userId 传入的用户 id
     * @return int 1:成功 0:失败
     */
    public int userDelete(Integer userId) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "delete from tb_user where user_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            //3. 执行语句
            rel = preparedStatement.executeUpdate();
            //4. 处理执行结果
        } catch(SQLException e) {
            rel = -1;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return rel;
    }


    /**
     * 根据 id 修改指定用户信息
     * @param user 传入的鲜花类型实体类对象
     * @return int 1:成功 0:失败
     */
    public int userUpdate(User user) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "update tb_user set user_name = ?, user_password = ?, user_telephone = ?, user_email = ?, user_address = ?, user_flag = ? where users_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getUserPassword());
            preparedStatement.setString(3, user.getUserTelephone());
            preparedStatement.setString(4, user.getUserEmail());
            preparedStatement.setString(5, user.getUserAddress());
            preparedStatement.setInt(6, user.getUserFlag());
            preparedStatement.setInt(7, user.getUserId());
            //3. 执行语句
            rel = preparedStatement.executeUpdate();
            //4. 处理执行结果
        } catch(SQLException e) {
            rel = -1;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return rel;
    }

    /**
     * 通过 id 查询用户信息
     * @param userId 传入的 id
     * @return 用户实体类对象 1.null 异常 2.User 对象 有值 3.User 对象无值
     */
    public User userQueryOne(Integer userId) {
        User user = new User();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_user where user_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            if (resultSet.next()) {
                user.setUserId(resultSet.getInt(1));
                user.setUserName(resultSet.getString(2));
                user.setUserPassword(resultSet.getString(3));
                user.setUserTelephone(resultSet.getString(4));
                user.setUserEmail(resultSet.getString(5));
                user.setUserAddress(resultSet.getString(6));
                user.setUserFlag(resultSet.getInt(7));
            }
        } catch(SQLException e) {
            user = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return user;
    }

    /**
     * 返回全部用户信息
     * @return 存储全部用户信息的 list 1.null 异常 2.list.size() == 0 对象 没有数据 3. size > 0 有数据
     */
    public List<User> userQueryAll() {
        List<User> userList = new ArrayList<>();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_user";
            preparedStatement = connection.prepareStatement(sql);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt(1));
                user.setUserName(resultSet.getString(2));
                user.setUserPassword(resultSet.getString(3));
                user.setUserTelephone(resultSet.getString(4));
                user.setUserEmail(resultSet.getString(5));
                user.setUserAddress(resultSet.getString(6));
                user.setUserFlag(resultSet.getInt(7));
                userList.add(user);
            }
        } catch(SQLException e) {
            userList = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return userList;
    }
}