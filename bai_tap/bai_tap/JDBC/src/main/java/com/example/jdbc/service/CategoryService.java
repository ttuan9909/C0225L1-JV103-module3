package com.example.jdbc.service;

import com.example.jdbc.entity.Category;
import com.example.jdbc.repository.CategoryRepository;
import com.example.jdbc.repository.ICategoryRepository;

import java.util.List;

public class CategoryService implements ICategoryService {
    private final ICategoryRepository repo = new CategoryRepository();

    @Override
    public List<Category> getAll() {
        return repo.findAll();
    }

    @Override
    public Category getById(int id) {
        return repo.findById(id);
    }

    @Override
    public void create(String name) {
        repo.save(new Category(0, name));
    }

    @Override
    public boolean update(int id, String name) {
        Category c = repo.findById(id);
        if (c == null) return false;
        c.setName(name);
        repo.update(c);
        return true;
    }

    @Override
    public boolean delete(int id) {
        return repo.deleteById(id);
    }

    @Override
    public List<Category> search(String keyword) {
        return repo.searchByName(keyword);
    }
}
