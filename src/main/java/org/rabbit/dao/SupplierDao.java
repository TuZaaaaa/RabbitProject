package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.FlowerType;
import org.rabbit.vo.Supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Rabbit
 */
public class SupplierDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 通过 id 查询供应商信息
     * @param supplierId 传入的 id
     * @return 供应商实体类对象 1.null 异常 2.Supplier 对象 有值 3.Supplier 对象无值
     */
    public Supplier supplierQueryOne(Integer supplierId) {
        Supplier supplier = new Supplier();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_supplier where supplier_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, supplierId);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            if (resultSet.next()) {
                supplier.setSupplierId(resultSet.getInt(1));
                supplier.setSupplierName(resultSet.getString(2));
                supplier.setSupplierAddress(resultSet.getString(3));
            }
        } catch(SQLException e) {
            supplier = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return supplier;
    }
}