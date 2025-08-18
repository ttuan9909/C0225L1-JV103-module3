package com.example.jdbc.dto;

public class ProductDto {
    private int id;
    private String name;
    private int price;
    private int quantity;
    private String categoryName;

    public ProductDto() {
    }

    public ProductDto(int id, String name, int price, int quantity, String categoryName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.categoryName = categoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}
