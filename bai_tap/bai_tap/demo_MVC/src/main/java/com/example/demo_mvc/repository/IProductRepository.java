package com.example.demo_mvc.repository;

import com.example.demo_mvc.entity.Product;

import java.util.List;
import java.util.Optional;

public interface IProductRepository {
    List<Product> findAll();
    Product findById(int id);
    void save(Product product);        // tạo mới (tự tăng id)
    void update(Product product);      // cập nhật theo product.id
    boolean deleteById(int id);
    List<Product> searchByName(String keyword);

}
