package com.example.jdbc.service;

import com.example.jdbc.entity.Category;

import java.util.List;

public interface ICategoryService {
    List<Category> getAll();
    Category getById(int id);
    void create(String name);
    boolean update(int id, String name);
    boolean delete(int id);
    List<Category> search(String keyword);
}
