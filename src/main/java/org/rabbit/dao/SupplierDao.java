package org.rabbit.dao;

import org.rabbit.util.MySqlConnection;
import org.rabbit.vo.Supplier;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Rabbit
 */
public class SupplierDao {
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;
    private String sql = "";

    /**
     * 添加供应商信息
     * @param supplier 鲜花类型实体类对象
     * @return int 1:成功 0:失败 -1:异常
     */
    public int supplierAdd(Supplier supplier) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "insert into tb_supplier values(?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, supplier.getSupplierId());
            preparedStatement.setString(2, supplier.getSupplierName());
            preparedStatement.setString(3, supplier.getSupplierAddress());
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
     * 根据 id 删除指定供应商信息
     * @param supplierId 传入的供应商 id
     * @return int 1:成功 0:失败
     */
    public int supplierDelete(Integer supplierId) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "delete from tb_supplier where supplier_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, supplierId);
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
     * 根据 id 修改指定供应商信息
     * @param supplier 传入的供应商实体类对象
     * @return int 1:成功 0:失败
     */
    public int supplierUpdate(Supplier supplier) {
        int rel = 0;
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "update tb_supplier set supplier_name = ?, supplier_address = ? where supplier_id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, supplier.getSupplierName());
            preparedStatement.setString(2, supplier.getSupplierAddress());
            preparedStatement.setInt(3, supplier.getSupplierId());
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

    /**
     * 返回全部供应商信息
     * @return 存储全部鲜花信息的 list 1.null 异常 2.list.size() == 0 对象 没有数据 3. size > 0 有数据
     */
    public List<Supplier> supplierQueryAll() {
        List<Supplier> supplierList = new ArrayList<>();
        try {
            //1. 连接数据库
            if(connection == null || connection.isClosed()) {
                connection = MySqlConnection.getConnection();
            }
            //2. 书写 sql 语句
            sql = "select * from tb_supplier";
            preparedStatement = connection.prepareStatement(sql);
            //3. 执行语句
            resultSet = preparedStatement.executeQuery();
            //4. 处理执行结果
            while (resultSet.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierId(resultSet.getInt(1));
                supplier.setSupplierName(resultSet.getString(2));
                supplier.setSupplierAddress(resultSet.getString(3));
                supplierList.add(supplier);
            }
        } catch(SQLException e) {
            supplierList = null;
            e.printStackTrace();
        } finally {
            //5. 关闭数据库连接
            MySqlConnection.closeConnection();
        }
        return supplierList;
    }
}