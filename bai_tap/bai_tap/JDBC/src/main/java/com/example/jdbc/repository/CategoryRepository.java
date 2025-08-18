package com.example.jdbc.repository;

import com.example.jdbc.entity.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class CategoryRepository implements ICategoryRepository {
    private static final String SELECT_ALL     = "SELECT id, name FROM category;";
    private static final String SELECT_BY_ID   = "SELECT id, name FROM category WHERE id = ?;";
    private static final String INSERT_INTO    = "INSERT INTO category(name) VALUES (?);";
    private static final String UPDATE_BY_ID   = "UPDATE category SET name = ? WHERE id = ?;";
    private static final String DELETE_BY_ID   = "DELETE FROM category WHERE id = ?;";
    private static final String SEARCH_BY_NAME = "SELECT id, name FROM category WHERE LOWER(name) LIKE ?;";

    @Override
    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("name")));
            }
        } catch (Exception e) {
            System.out.println("Lỗi query Category.findAll");
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category findById(int id) {
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return new Category(rs.getInt("id"), rs.getString("name"));
            }
        } catch (Exception e) {
            System.out.println("Lỗi query Category.findById");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean save(Category c) {
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(INSERT_INTO)) {
            ps.setString(1, c.getName());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            System.out.println("Lỗi query Category.save");
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void update(Category c) {
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(UPDATE_BY_ID)) {
            ps.setString(1, c.getName());
            ps.setInt(2, c.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi query Category.update");
            e.printStackTrace();
        }
    }

    @Override
    public boolean deleteById(int id) {
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(DELETE_BY_ID)) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            System.out.println("Lỗi query Category.deleteById");
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Category> searchByName(String keyword) {
        String k = (keyword == null) ? "" : keyword.trim().toLowerCase();
        if (k.isEmpty()) return findAll();

        List<Category> results = new ArrayList<>();
        try (Connection con = BaseRepository.getConnectDB();
             PreparedStatement ps = con.prepareStatement(SEARCH_BY_NAME)) {
            ps.setString(1, "%" + k + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(new Category(rs.getInt("id"), rs.getString("name")));
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi query Category.searchByName");
            e.printStackTrace();
        }
        return results.isEmpty() ? Collections.emptyList() : results;
    }
}
