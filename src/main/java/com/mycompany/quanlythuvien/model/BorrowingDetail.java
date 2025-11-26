package com.mycompany.quanlythuvien.model;

public class BorrowingDetail {
    private int id;
    private int borrowingId;
    private int bookId;
    
    public BorrowingDetail() {}
    
    public BorrowingDetail(int id, int borrowingId, int bookId) {
        this.id = id;
        this.borrowingId = borrowingId;
        this.bookId = bookId;
    }
    
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    public int getBorrowingId() {
        return borrowingId;
    }
    public void setBorrowingId(int borrowingId) {
        this.borrowingId = borrowingId;
    }
    public int getBookId() {
        return bookId;
    }
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    
}