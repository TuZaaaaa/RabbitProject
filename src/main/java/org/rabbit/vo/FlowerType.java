package org.rabbit.vo;

/**
 * @author Rabbit
 */
public class FlowerType {
    private Integer typeId;
    private String typeName;
    private String typeDepict;

    public FlowerType() {
    }

    public FlowerType(Integer typeId, String typeName, String typeDepict) {
        this.typeId = typeId;
        this.typeName = typeName;
        this.typeDepict = typeDepict;
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

    public String getTypeDepict() {
        return typeDepict;
    }

    public void setTypeDepict(String typeDepict) {
        this.typeDepict = typeDepict;
    }
}