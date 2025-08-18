package com.example.jdbc.service;

import com.example.jdbc.dto.ProductDto;
import com.example.jdbc.entity.Product;
import java.util.List;

public interface IProductService {
    List<ProductDto> findAll();
    ProductDto getById(int id);                         // trả về DTO
    void create(String name, int price, int quantity, int categoryId);
    boolean update(int id, String name, int price, int quantity, int categoryId);
    boolean delete(int id);
    List<ProductDto> search(String keyword);
}
