package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Rabbit
 */
public class OrderDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 添加订单信息
     * @param order 订单实体类对象
     * @return int 1:成功 0:失败 -1:异常
     */
    public int orderAdd(Order order) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "insert into tb_order values(?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, order.getOrderId());
            preparedStatement.setInt(2, order.getFlowerId());
            preparedStatement.setString(3, order.getOrderAddress());
            preparedStatement.setString(4, order.getOrderDepict());
//            preparedStatement.setDate(5, new java.sql.Date(new Date().getTime()));
            preparedStatement.setDate(5, new java.sql.Date(System.currentTimeMillis()));
            preparedStatement.setInt(6, order.getOrderFlag());
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
     * 根据 id 删除指定订单信息
     * @param orderId 传入的鲜花 id
     * @return int 1:成功 0:失败
     */
    public int orderDelete(Integer orderId) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "delete from tb_order where order_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, orderId);
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
     * 根据 id 修改指定订单信息
     * @param order 传入的鲜花实体类对象
     * @return int 1:成功 0:失败
     */
    public int orderUpdate(Order order) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "update tb_order set flower_id = ?, order_address = ?, order_depict = ?, order_flag = ? where order_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, order.getFlowerId());
            preparedStatement.setString(2, order.getOrderAddress());
            preparedStatement.setString(3, order.getOrderDepict());
//            preparedStatement.setDate(4, (Date) order.getOrderTime());
            preparedStatement.setInt(4, order.getOrderFlag());
            preparedStatement.setInt(5, order.getOrderId());
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
     * 通过 id 查询订单信息
     * @param orderId 传入的 id
     * @return 订单实体类对象 1.null 异常 2.order 对象 有值 3.order 对象无值
     */
    public Order  orderQueryOne(Integer orderId) {
        Order order = new Order();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_order where order_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, orderId);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            if (resultSet.next()) {
                order.setOrderId(resultSet.getInt(1));
                order.setFlowerId(resultSet.getInt(2));
                order.setOrderAddress(resultSet.getString(3));
                order.setOrderDepict(resultSet.getString(4));
                order.setOrderTime(resultSet.getDate(5));
                order.setOrderFlag(resultSet.getInt(6));
            }
        } catch(SQLException e) {
            order = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return order;
    }

    /**
     * 返回全部订单信息
     * @return 存储全部订单信息的 list 1.null 异常 2.list.size() == 0 对象 没有数据 3. size > 0 有数据
     */
    public List<Order> orderQueryAll() {
        List<Order> orderList = new ArrayList<>();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_order";
            preparedStatement = connection.prepareStatement(sql);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            while (resultSet.next()) {
                Order order = new Order();
                order.setOrderId(resultSet.getInt(1));
                order.setFlowerId(resultSet.getInt(2));
                order.setOrderAddress(resultSet.getString(3));
                order.setOrderDepict(resultSet.getString(4));
                order.setOrderTime(resultSet.getDate(5));
                order.setOrderFlag(resultSet.getInt(6));
                orderList.add(order);
            }
        } catch(SQLException e) {
            orderList = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return orderList;
    }

}