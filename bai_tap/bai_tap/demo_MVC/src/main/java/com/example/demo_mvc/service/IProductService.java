package com.example.demo_mvc.service;

import com.example.demo_mvc.entity.Product;

import java.util.List;

public interface IProductService {
    List<Product> getAll();
    Product getById(int id);
    void create(String name, int price, int quantity);
    boolean update(int id, String name, int price, int quantity);
    boolean delete(int id);
    List<Product> search(String keyword);

}
