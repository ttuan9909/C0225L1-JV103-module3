CREATE DATABASE demo;

USE demo;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50) NOT NULL UNIQUE,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus BOOLEAN DEFAULT TRUE
);

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES 
('P001', 'Bàn học thông minh', 1200000.00, 10, 'Bàn học cho học sinh tiểu học, chống gù, chống cận.', TRUE),
('P002', 'Ghế công thái học', 2500000.00, 5, 'Ghế ngồi làm việc thoải mái, phù hợp dân văn phòng.', TRUE),
('P003', 'Đèn bàn LED cảm ứng', 450000.00, 20, 'Đèn bàn chống cận, điều chỉnh độ sáng cảm ứng.', TRUE),
('P004', 'Kệ sách mini', 300000.00, 15, 'Kệ sách nhỏ gọn để bàn làm việc.', FALSE),
('P005', 'Thảm lót sàn văn phòng', 800000.00, 0, 'Thảm lót sàn cao cấp, êm ái, cách nhiệt tốt.', FALSE),
('P006', 'Bàn làm việc chữ L', 3200000.00, 3, 'Bàn làm việc góc rộng, chất liệu MDF phủ melamine.', TRUE),
('P007', 'Tủ sách 5 tầng', 2100000.00, 7, 'Tủ sách đứng, kiểu dáng hiện đại, màu gỗ sồi.', TRUE),
('P008', 'Bảng ghim văn phòng', 150000.00, 30, 'Bảng ghim treo tường, tiện lợi cho ghi chú.', TRUE),
('P009', 'Ghế xếp gọn mini', 120000.00, 25, 'Ghế xếp gọn tiện lợi cho sinh viên, du lịch.', TRUE),
('P010', 'Quạt để bàn USB', 220000.00, 18, 'Quạt mini để bàn, kết nối cổng USB, tiết kiệm điện.', TRUE),
('P011', 'Bàn gấp thông minh', 950000.00, 12, 'Bàn gấp gọn phù hợp cho không gian nhỏ.', TRUE),
('P012', 'Giá treo màn hình', 650000.00, 6, 'Giá treo giúp điều chỉnh độ cao và góc màn hình dễ dàng.', TRUE),
('P013', 'Ghế đẩu nhựa', 90000.00, 50, 'Ghế đẩu nhỏ, nhẹ, tiện dụng cho mọi không gian.', TRUE),
('P014', 'Tủ hồ sơ 2 cánh', 2700000.00, 4, 'Tủ đựng tài liệu văn phòng, khóa an toàn.', TRUE),
('P015', 'Khay đựng tài liệu 3 tầng', 180000.00, 40, 'Khay nhựa đựng giấy A4, gọn gàng, dễ sắp xếp.', TRUE);

CREATE UNIQUE INDEX unique_productCode ON Products(productCode);
CREATE INDEX composite_name_price ON Products(productName, productPrice);
EXPLAIN SELECT * FROM Products WHERE productName = 'Ghế công thái học' AND productPrice = 2500000.00;
EXPLAIN SELECT * FROM Products WHERE productCode = 'P002';

CREATE VIEW view_product AS
SELECT 
    productCode, 
    productName, 
    productPrice, 
    productStatus
FROM 
    Products;

-- Lấy tất cả sản phẩm
DELIMITER //

CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM Products;
END //

DELIMITER ;

-- Thêm sản phẩm mới
DELIMITER //

CREATE PROCEDURE addProduct(
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10,2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    INSERT INTO Products (
        productCode,
        productName,
        productPrice,
        productAmount,
        productDescription,
        productStatus
    ) VALUES (
        p_productCode,
        p_productName,
        p_productPrice,
        p_productAmount,
        p_productDescription,
        p_productStatus
    );
END //

DELIMITER ;

-- Cập nhật sản phẩm
DELIMITER //

CREATE PROCEDURE updateProductById(
    IN p_Id INT,
    IN p_productCode VARCHAR(50),
    IN p_productName VARCHAR(100),
    IN p_productPrice DECIMAL(10,2),
    IN p_productAmount INT,
    IN p_productDescription TEXT,
    IN p_productStatus BOOLEAN
)
BEGIN
    UPDATE Products
    SET
        productCode = p_productCode,
        productName = p_productName,
        productPrice = p_productPrice,
        productAmount = p_productAmount,
        productDescription = p_productDescription,
        productStatus = p_productStatus
    WHERE Id = p_Id;
END //

DELIMITER ;

-- Xóa sản phẩm
DELIMITER //

CREATE PROCEDURE deleteProductById(IN p_Id INT)
BEGIN
    DELETE FROM Products WHERE Id = p_Id;
END //

DELIMITER ;


CALL getAllProducts();

CALL addProduct('P100', 'Bút bi Thiên Long', 5000, 100, 'Bút bi xanh, viết êm', TRUE);

CALL updateProductById(1, 'P001', 'Bàn học thông minh', 1250000, 15, 'Cập nhật mô tả mới', TRUE);

CALL deleteProductById(1);


