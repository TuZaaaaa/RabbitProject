package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.FlowerType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Rabbit
 */
public class FlowerTypeDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 添加鲜花类型信息
     * @param flowerType 鲜花类型实体类对象
     * @return int 1:成功 0:失败 -1:异常
     */
    public int flowerTypeAdd(FlowerType flowerType) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "insert into tb_type values(?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, flowerType.getTypeId());
            preparedStatement.setString(2, flowerType.getTypeName());
            preparedStatement.setString(3, flowerType.getTypeDepict());
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
     * 根据 id 删除指定鲜花类型信息
     * @param typeId 传入的鲜花类型 id
     * @return int 1:成功 0:失败
     */
    public int flowerDelete(Integer typeId) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "delete from tb_type where type_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, typeId);
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
     * 根据 id 修改指定鲜花类型信息
     * @param flowerType 传入的鲜花类型实体类对象
     * @return int 1:成功 0:失败
     */
    public int flowerUpdate(FlowerType flowerType) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "update tb_type set type_name = ?, type_depict = ? where type_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, flowerType.getTypeName());
            preparedStatement.setString(2, flowerType.getTypeDepict());
            preparedStatement.setInt(3, flowerType.getTypeId());
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
                flowerType.setTypeDepict(resultSet.getString(3));
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

    /**
     * 返回全部鲜花类型信息
     * @return 存储全部鲜花信息的 list 1.null 异常 2.list.size() == 0 对象 没有数据 3. size > 0 有数据
     */
    public List<FlowerType> flowerTypeQueryAll() {
        List<FlowerType> flowerTypeList = new ArrayList<>();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_type";
            preparedStatement = connection.prepareStatement(sql);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            while (resultSet.next()) {
                FlowerType flowerType = new FlowerType();
                flowerType.setTypeId(resultSet.getInt(1));
                flowerType.setTypeName(resultSet.getString(2));
                flowerType.setTypeDepict(resultSet.getString(3));
                flowerTypeList.add(flowerType);
            }
        } catch(SQLException e) {
            flowerTypeList = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return flowerTypeList;
    }
}