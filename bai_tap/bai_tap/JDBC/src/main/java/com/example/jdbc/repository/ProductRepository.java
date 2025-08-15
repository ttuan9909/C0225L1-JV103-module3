package com.example.jdbc.repository;

import com.example.jdbc.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class ProductRepository implements IProductRepository {
    private static final String SELECT_ALL      = "SELECT * FROM product;";
    private static final String INSERT_INTO     = "INSERT INTO product(name, price, quantity) VALUES (?, ?, ?);";
    private static final String SELECT_BY_ID    = "SELECT * FROM product WHERE id = ?;";
    private static final String UPDATE_BY_ID    = "UPDATE product SET name = ?, price = ?, quantity = ? WHERE id = ?;";
    private static final String DELETE_BY_ID    = "DELETE FROM product WHERE id = ?;";
    private static final String SEARCH_BY_NAME  = "SELECT * FROM product WHERE LOWER(name) LIKE ?;";


    @Override
    public List<Product> findAll() {
        List<Product> productList = new ArrayList<>();
        try (Connection connection = BaseRepository.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                int price = resultSet.getInt("price");
                int quantity = resultSet.getInt("quantity");
                Product product = new Product(id, name, price, quantity);
                productList.add(product);
            }
        } catch (Exception e) {
            System.out.println("Lôỗi query");
        }
        return productList;
    }

    @Override
    public Product findById(int id) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    return new Product(id, name, price, quantity);
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi query findById");
            e.printStackTrace();
        }
        return null; // không tìm thấy
    }


    @Override
    public boolean save(Product product) {
        try (Connection connection = BaseRepository.getConnectDB();) {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_INTO);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setInt(2, product.getPrice());
            preparedStatement.setInt(3, product.getQuantity());
            int effectRow = preparedStatement.executeUpdate();
            return effectRow == 1;
        } catch (Exception e) {
            System.out.println("Lõi query");
        }
        return false;
    }

    @Override
    public void update(Product product) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(UPDATE_BY_ID)) {

            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setInt(4, product.getId());
            ps.executeUpdate(); // có thể kiểm tra số dòng ảnh hưởng nếu muốn
        } catch (Exception e) {
            System.out.println("Lỗi query update");
            e.printStackTrace();
        }
    }

    @Override
    public boolean deleteById(int id) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(DELETE_BY_ID)) {

            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            return affected == 1;
        } catch (Exception e) {
            System.out.println("Lỗi query deleteById");
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Product> searchByName(String keyword) {
        String k = (keyword == null) ? "" : keyword.trim().toLowerCase();
        if (k.isEmpty()) {
            return findAll();
        }

        List<Product> results = new ArrayList<>();
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SEARCH_BY_NAME)) {

            ps.setString(1, "%" + k + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    results.add(new Product(id, name, price, quantity));
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi query searchByName");
            e.printStackTrace();
        }
        return results.isEmpty() ? Collections.emptyList() : results;
    }
}
