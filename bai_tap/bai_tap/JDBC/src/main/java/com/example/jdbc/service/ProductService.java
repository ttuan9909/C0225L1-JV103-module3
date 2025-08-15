package com.example.jdbc.service;

import com.example.jdbc.entity.Product;
import com.example.jdbc.repository.IProductRepository;
import com.example.jdbc.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {
    private final IProductRepository repository = new ProductRepository();

    @Override
    public List<Product> getAll() {
        return repository.findAll();
    }

    @Override
    public Product getById(int id) {
        return repository.findById(id);
    }

    @Override
    public void create(String name, int price, int quantity) {
        repository.save(new Product(0, name, price, quantity));
    }

    @Override
    public boolean update(int id, String name, int price, int quantity) {
        Product existed = repository.findById(id);
        if (existed == null) return false;
        existed.setName(name);
        existed.setPrice(price);
        existed.setQuantity(quantity);
        repository.update(existed);
        return true;
    }

    @Override
    public boolean delete(int id) {
        return repository.deleteById(id);
    }

    @Override
    public List<Product> search(String keyword) {
        return repository.searchByName(keyword);
    }
}
