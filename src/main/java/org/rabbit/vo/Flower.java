package org.rabbit.vo;

import java.math.BigDecimal;

/**
 * @author Rabbit
 */
public class Flower {
    private Integer flowerId;
    private String flowerName;
    private int typeId;
    private BigDecimal flowerPrice;
    private int flowerStock;
    private int flowerSell;
    private int SupplierId;

    public Flower() {
    }

    public Flower(Integer flowerId, String flowerName, int typeId, BigDecimal flowerPrice, int flowerStock, int flowerSell, int supplierId) {
        this.flowerId = flowerId;
        this.flowerName = flowerName;
        this.typeId = typeId;
        this.flowerPrice = flowerPrice;
        this.flowerStock = flowerStock;
        this.flowerSell = flowerSell;
        SupplierId = supplierId;
    }

    public Integer getFlowerId() {
        return flowerId;
    }

    public void setFlowerId(Integer flowerId) {
        this.flowerId = flowerId;
    }

    public String getFlowerName() {
        return flowerName;
    }

    public void setFlowerName(String flowerName) {
        this.flowerName = flowerName;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public BigDecimal getFlowerPrice() {
        return flowerPrice;
    }

    public void setFlowerPrice(BigDecimal flowerPrice) {
        this.flowerPrice = flowerPrice;
    }

    public int getFlowerStock() {
        return flowerStock;
    }

    public void setFlowerStock(int flowerStock) {
        this.flowerStock = flowerStock;
    }

    public int getFlowerSell() {
        return flowerSell;
    }

    public void setFlowerSell(int flowerSell) {
        this.flowerSell = flowerSell;
    }

    public int getSupplierId() {
        return SupplierId;
    }

    public void setSupplierId(int supplierId) {
        SupplierId = supplierId;
    }
}