package com.example.jdbc.service;

import com.example.jdbc.dto.ProductDto;
import com.example.jdbc.entity.Product;
import com.example.jdbc.repository.IProductRepository;
import com.example.jdbc.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {
    private final IProductRepository repository = new ProductRepository();

    // ===== READ (DTO) =====
    @Override
    public List<ProductDto> findAll() {
        return repository.findAll();              // trả về DTO
    }

    @Override
    public ProductDto getById(int id) {           // đổi kiểu trả về -> DTO
        return repository.findById(id);           // lấy theo JOIN (có categoryName)
    }

    @Override
    public List<ProductDto> search(String keyword) {
        return repository.searchByName(keyword);  // trả về DTO
    }

    // ===== WRITE (ENTITY) =====
    @Override
    public void create(String name, int price, int quantity, int categoryId) {
        repository.save(new Product(0, name, price, quantity, categoryId));
    }

    @Override
    public boolean update(int id, String name, int price, int quantity, int categoryId) {
        // kiểm tra tồn tại bằng DTO (đọc view). Nếu không có -> false.
        if (repository.findById(id) == null) return false;

        // cập nhật bằng entity
        Product toUpdate = new Product(id, name, price, quantity, categoryId);
        repository.update(toUpdate);
        return true;
    }

    @Override
    public boolean delete(int id) {
        return repository.deleteById(id);
    }
}
