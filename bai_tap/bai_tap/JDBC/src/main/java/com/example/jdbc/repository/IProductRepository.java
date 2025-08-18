package com.example.jdbc.repository;

import com.example.jdbc.dto.ProductDto;
import com.example.jdbc.entity.Product;

import java.util.List;

public interface IProductRepository {
    List<ProductDto> findAll();
    ProductDto findById(int id);
    List<ProductDto> searchByName(String keyword);

    // WRITE -> Entity
    boolean save(Product product);
    void update(Product product);
    boolean deleteById(int id);
}

