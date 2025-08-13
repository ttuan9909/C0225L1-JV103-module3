<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.example.demo_mvc.entity.Product" %>
<%
  String mode = (String) request.getAttribute("mode"); // "create" | "edit"
  Product p = (Product) request.getAttribute("product");
  boolean editing = "edit".equals(mode);
%>
<html>
<head><title><%= editing ? "Sửa" : "Thêm" %> sản phẩm</title></head>
<body>
<h2><%= editing ? "Sửa" : "Thêm" %> sản phẩm</h2>

<form method="post" action="${pageContext.request.contextPath}/products">
  <input type="hidden" name="action" value="<%= editing ? "edit" : "create" %>"/>
  <% if (editing) { %>
  <input type="hidden" name="id" value="<%= p.getId() %>"/>
  <% } %>

  <p>
    <label>Tên sản phẩm:</label><br/>
    <input name="name" required value="<%= editing ? p.getName() : "" %>"/>
  </p>
  <p>
    <label>Giá (VND):</label><br/>
    <input name="price" type="number" min="0" step="1" required value="<%= editing ? p.getPrice() : "" %>"/>
  </p>
  <p>
    <label>Số lượng:</label><br/>
    <input name="quantity" type="number" min="0" step="1" required value="<%= editing ? p.getQuantity() : "" %>"/>
  </p>

  <p>
    <button type="submit"><%= editing ? "Cập nhật" : "Tạo mới" %></button>
    <a href="${pageContext.request.contextPath}/products?action=list">Huỷ</a>
  </p>
</form>
</body>
</html>
