package org.rabbit.vo;

import java.math.BigDecimal;

/**
 * @author Rabbit
 */
public class Flower {
    private Integer flowerId;
    private String flowerName;
    private String flowerType;
    private BigDecimal flowerPrice;
    private int flowerStock;
    private int flowerSell;
    private String flowerSupplier;

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

    public String getFlowerType() {
        return flowerType;
    }

    public void setFlowerType(String flowerType) {
        this.flowerType = flowerType;
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

    public String getFlowerSupplier() {
        return flowerSupplier;
    }

    public void setFlowerSupplier(String flowerSupplier) {
        this.flowerSupplier = flowerSupplier;
    }
}