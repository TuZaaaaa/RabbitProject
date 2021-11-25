package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.Flower;
import org.rabbit.vo.FlowerType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Rabbit
 */
public class FlowerTypeDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 通过 id 查询鲜花类型信息
     * @param flowerTypeId 传入的 id
     * @return 鲜花类型实体类对象 1.null 异常 2.FlowerType 对象 有值 3. FlowerType 对象无值
     */
    public FlowerType flowerTypeQueryOne(Integer flowerTypeId) {
        FlowerType flowerType = new FlowerType();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_type where type_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, flowerTypeId);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            if (resultSet.next()) {
                flowerType.setTypeId(resultSet.getInt(1));
                flowerType.setTypeName(resultSet.getString(2));
            }
        } catch(SQLException e) {
            flowerType = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return flowerType;
    }
}