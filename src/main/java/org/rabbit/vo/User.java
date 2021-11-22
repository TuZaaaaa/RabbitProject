package org.rabbit.vo;

/**
 * @author Rabbit
 */
public class User {
    private Integer userId;
    private String userName;
    private String userPassword;
    private String userTelephone;
    private String userEmail;
    private String userAddress;
    private int userFlag;

    public User() {
    }

    public User(Integer userId, String userName, String userPassword, String userTelephone, String userEmail, String userAddress, int userFlag) {
        this.userId = userId;
        this.userName = userName;
        this.userPassword = userPassword;
        this.userTelephone = userTelephone;
        this.userEmail = userEmail;
        this.userAddress = userAddress;
        this.userFlag = userFlag;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserTelephone() {
        return userTelephone;
    }

    public void setUserTelephone(String userTelephone) {
        this.userTelephone = userTelephone;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public int getUserFlag() {
        return userFlag;
    }

    public void setUserFlag(int userFlag) {
        this.userFlag = userFlag;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", userPassword='" + userPassword + '\'' +
                ", userTelephone='" + userTelephone + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userAddress='" + userAddress + '\'' +
                ", userFlag=" + userFlag +
                '}';
    }
}