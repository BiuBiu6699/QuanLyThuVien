package com.mycompany.quanlythuvien.model;

public class Book {
    private int id;
    private String title;
    private String author;
    private int categoryId;
    private int quantity;
    private String imageUrl;

    // Constructors, Getters, and Setters
    public Book() {}

    public Book(int id, String title, String author, int categoryId, int quantity, String imageUrl) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.categoryId = categoryId;
        this.quantity = quantity;
        this.imageUrl = imageUrl;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}