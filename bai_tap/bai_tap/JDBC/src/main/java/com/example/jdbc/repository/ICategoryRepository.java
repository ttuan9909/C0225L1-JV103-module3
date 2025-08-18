package com.example.jdbc.repository;

import com.example.jdbc.entity.Category;

import java.util.List;

public interface ICategoryRepository {
    List<Category> findAll();
    Category findById(int id);
    boolean save(Category c);
    void update(Category c);
    boolean deleteById(int id);
    List<Category> searchByName(String keyword);
}
