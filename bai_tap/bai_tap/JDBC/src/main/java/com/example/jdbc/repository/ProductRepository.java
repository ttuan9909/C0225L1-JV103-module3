package com.example.jdbc.repository;

import com.example.jdbc.dto.ProductDto;
import com.example.jdbc.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class ProductRepository implements IProductRepository {

    // ====== SQL (VIEW: JOIN để có category_name) ======
    private static final String SELECT_ALL_VIEW =
            "SELECT p.id, p.name, p.price, p.quantity, c.name AS category_name " +
                    "FROM product p LEFT JOIN category c ON p.category_id = c.id;";

    private static final String SELECT_VIEW_BY_ID =
            "SELECT p.id, p.name, p.price, p.quantity, c.name AS category_name " +
                    "FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE p.id = ?;";

    private static final String SEARCH_VIEW_BY_NAME =
            "SELECT p.id, p.name, p.price, p.quantity, c.name AS category_name " +
                    "FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE LOWER(p.name) LIKE ?;";

    // ====== SQL (WRITE: thao tác entity Product) ======
    private static final String INSERT_INTO =
            "INSERT INTO product(name, price, quantity, category_id) VALUES (?, ?, ?, ?);";

    private static final String UPDATE_BY_ID =
            "UPDATE product SET name = ?, price = ?, quantity = ?, category_id = ? WHERE id = ?;";

    private static final String DELETE_BY_ID =
            "DELETE FROM product WHERE id = ?;";

    // ================== READ (DTO) ==================

    @Override
    public List<ProductDto> findAll() {
        List<ProductDto> productList = new ArrayList<>();
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_VIEW);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productList.add(new ProductDto(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getString("category_name") // <- chỉ lấy tên danh mục
                ));
            }
        } catch (Exception e) {
            System.out.println("Lỗi query findAll");
            e.printStackTrace();
        }
        return productList;
    }

    @Override
    public ProductDto findById(int id) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SELECT_VIEW_BY_ID)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ProductDto(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("price"),
                            rs.getInt("quantity"),
                            rs.getString("category_name")
                    );
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi query findById (view)");
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProductDto> searchByName(String keyword) {
        String k = (keyword == null) ? "" : keyword.trim().toLowerCase();
        if (k.isEmpty()) {
            return findAll();
        }

        List<ProductDto> results = new ArrayList<>();
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(SEARCH_VIEW_BY_NAME)) {

            ps.setString(1, "%" + k + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    results.add(new ProductDto(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("price"),
                            rs.getInt("quantity"),
                            rs.getString("category_name")
                    ));
                }
            }
        } catch (Exception e) {
            System.out.println("Lỗi query searchByName (view)");
            e.printStackTrace();
        }
        return results.isEmpty() ? Collections.emptyList() : results;
    }

    // ================== WRITE (ENTITY) ==================

    @Override
    public boolean save(Product product) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(INSERT_INTO)) {

            ps.setString(1, product.getName());
            ps.setInt(2, product.getPrice());
            ps.setInt(3, product.getQuantity());
            ps.setInt(4, product.getCategoryId()); // categoryId bắt buộc (đã thống nhất)

            int effectRow = ps.executeUpdate();
            return effectRow == 1;
        } catch (Exception e) {
            System.out.println("Lỗi query save");
            e.printStackTrace();
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
            ps.setInt(4, product.getCategoryId());
            ps.setInt(5, product.getId());
            ps.executeUpdate();
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
}
