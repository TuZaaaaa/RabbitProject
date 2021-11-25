package org.rabbit.vo;

/**
 * @author Rabbit
 */
public class FlowerType {
    private Integer typeId;
    private String typeName;

    public FlowerType() {
    }

    public FlowerType(String typeName) {
        this.typeName = typeName;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}