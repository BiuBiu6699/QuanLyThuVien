package com.mycompany.quanlythuvien.model;

import java.sql.Date;

public class Borrowing {
    private int id;
    private int userId;
    private Date borrowDate;
    private Date dueDate;
    private String status;
    private String userFullName;

    public Borrowing() {
    }
    
    public Borrowing(int id, int userId, Date borrowDate, Date dueDate, String status, String userFullName) {
        this.id = id;
        this.userId = userId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.status = status;
        this.userFullName = userFullName;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Date getBorrowDate() {
        return borrowDate;
    }
    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }
    public Date getDueDate() {
        return dueDate;
    }
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getUserFullName() {
        return userFullName;
    }
    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }
}