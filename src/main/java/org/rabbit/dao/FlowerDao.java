package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.Flower;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Rabbit
 */
public class FlowerDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 添加鲜花信息
     * @param flower 鲜花实体类对象
     * @return int 1:成功 0:失败 -1:异常
     */
    public int flowerAdd(Flower flower) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "insert into tb_flower values(?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, flower.getFlowerId());
            preparedStatement.setString(2, flower.getFlowerName());
            preparedStatement.setInt(3, flower.getTypeId());
            preparedStatement.setBigDecimal(4, flower.getFlowerPrice());
            preparedStatement.setInt(5, flower.getFlowerStock());
            preparedStatement.setInt(6, flower.getFlowerSell());
            preparedStatement.setInt(7, flower.getSupplierId());
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
     * 通过 id 查询鲜花信息
     * @param flowerId 传入的 id
     * @return 鲜花实体类对象 1.null 异常 2.Flower 对象 有值 3. Flower 对象无值
     */
    public  Flower flowerQueryOne(Integer flowerId) {
        Flower flower = new Flower();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_flower where flower_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, flowerId);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            if (resultSet.next()) {
                flower.setFlowerId(resultSet.getInt(1));
                flower.setFlowerName(resultSet.getString(2));
                flower.setTypeId(resultSet.getInt(3));
                flower.setFlowerPrice(resultSet.getBigDecimal(4));
                flower.setFlowerStock(resultSet.getInt(5));
                flower.setFlowerSell(resultSet.getInt(6));
                flower.setSupplierId(resultSet.getInt(7));
            }
        } catch(SQLException e) {
            flower = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return flower;
    }

    /**
     * 返回全部鲜花信息
     * @return 存储全部鲜花信息的 list 1.null 异常 2.list.size() == 0 对象 没有数据 3. size > 0 有数据
     */
    public List<Flower> flowerQueryAll() {
        List<Flower> flowerList = new ArrayList<>();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_flower";
            preparedStatement = connection.prepareStatement(sql);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            while (resultSet.next()) {
                Flower flower = new Flower();
                flower.setFlowerId(resultSet.getInt(1));
                flower.setFlowerName(resultSet.getString(2));
                flower.setTypeId(resultSet.getInt(3));
                flower.setFlowerPrice(resultSet.getBigDecimal(4));
                flower.setFlowerStock(resultSet.getInt(5));
                flower.setFlowerSell(resultSet.getInt(6));
                flower.setSupplierId(resultSet.getInt(7));
                flowerList.add(flower);
            }
        } catch(SQLException e) {
            flowerList = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return flowerList;
    }

    /**
     * 根据 id 删除指定鲜花信息
     * @param flowerId 传入的鲜花 id
     */
    public void delete(Integer flowerId) {
        
    }

}