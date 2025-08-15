package com.example.jdbc.repository;

import com.example.jdbc.entity.Product;

import java.util.List;

public interface IProductRepository {
    List<Product> findAll();
    Product findById(int id);
    boolean save(Product product);        // tạo mới (tự tăng id)
    void update(Product product);      // cập nhật theo product.id
    boolean deleteById(int id);
    List<Product> searchByName(String keyword);
}

