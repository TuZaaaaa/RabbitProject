package org.rabbit.vo;

import java.sql.Date;

/**
 * @author Rabbit
 */
public class Order {
    private Integer orderId;
    private int flowerId;
    private String orderAddress;
    private String orderDepict;
    private Date orderTime;
    private int orderFlag;

    public Order() {
    }

    public Order(Integer orderId, int flowerId, String orderAddress, String orderDepict, Date orderTime, int orderFlag) {
        this.orderId = orderId;
        this.flowerId = flowerId;
        this.orderAddress = orderAddress;
        this.orderDepict = orderDepict;
        this.orderTime = orderTime;
        this.orderFlag = orderFlag;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public int getFlowerId() {
        return flowerId;
    }

    public void setFlowerId(int flowerId) {
        this.flowerId = flowerId;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    public String getOrderDepict() {
        return orderDepict;
    }

    public void setOrderDepict(String orderDepict) {
        this.orderDepict = orderDepict;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public int getOrderFlag() {
        return orderFlag;
    }

    public void setOrderFlag(int orderFlag) {
        this.orderFlag = orderFlag;
    }
}