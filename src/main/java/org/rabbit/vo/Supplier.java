package org.rabbit.vo;

/**
 * @author Rabbit
 */
public class Supplier {
    private Integer supplierId;
    private String supplierName;
    private String supplierAddress;

    public Supplier() {
    }

    public Supplier(Integer supplierId, String supplierName, String supplierAddress) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.supplierAddress = supplierAddress;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getSupplierAddress() {
        return supplierAddress;
    }

    public void setSupplierAddress(String supplierAddress) {
        this.supplierAddress = supplierAddress;
    }
}