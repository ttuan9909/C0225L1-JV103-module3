package com.example.demo_mvc.service;

import com.example.demo_mvc.entity.Product;
import com.example.demo_mvc.repository.IProductRepository;
import com.example.demo_mvc.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;

public class ProductService implements IProductService {
    private final IProductRepository repo = new ProductRepository();

    @Override
    public List<Product> getAll() {
        return repo.findAll();
    }

    @Override
    public Product getById(int id) {
        return repo.findById(id);
    }

    @Override
    public void create(String name, int price, int quantity) {
        repo.save(new Product(0, name, price, quantity));
    }

    @Override
    public boolean update(int id, String name, int price, int quantity) {
        Product existed = repo.findById(id);
        if (existed == null) return false;
        existed.setName(name);
        existed.setPrice(price);
        existed.setQuantity(quantity);
        repo.update(existed);
        return true;
    }

    @Override
    public boolean delete(int id) {
        return repo.deleteById(id);
    }

    @Override
    public List<Product> search(String keyword) {
        return repo.searchByName(keyword);
    }
}
