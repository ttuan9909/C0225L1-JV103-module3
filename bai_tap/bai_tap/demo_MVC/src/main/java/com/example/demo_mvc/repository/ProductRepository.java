package com.example.demo_mvc.repository;

import com.example.demo_mvc.entity.Product;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductRepository implements IProductRepository {

    private static final List<Product> productList = new ArrayList<>();
    private static int currentId = 0;


    static {
        productList.add(new Product(++currentId, "iPhone 15", 25000000, 5));
        productList.add(new Product(++currentId, "Galaxy S24", 22000000, 7));
        productList.add(new Product(++currentId, "AirPods Pro", 5500000, 12));
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(productList);
    }

    @Override
    public Product findById(int id) {
        for (Product p : productList) {
            if (p.getId() == id) return p;
        }
        return null;
    }


    @Override
    public void save(Product product) {
        product.setId(++currentId);
        productList.add(product);
    }

    @Override
    public void update(Product product) {
        Product existing = findById(product.getId());
        if (existing != null) {
            existing.setName(product.getName());
            existing.setPrice(product.getPrice());
            existing.setQuantity(product.getQuantity());
        }
    }

    @Override
    public boolean deleteById(int id) {
        return productList.removeIf(p -> p.getId() == id);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        String k = (keyword == null) ? "" : keyword.trim().toLowerCase();
        if (k.isEmpty()) return findAll();
        return productList.stream()
                .filter(p -> p.getName() != null && p.getName().toLowerCase().contains(k))
                .collect(Collectors.toList());
    }
}
