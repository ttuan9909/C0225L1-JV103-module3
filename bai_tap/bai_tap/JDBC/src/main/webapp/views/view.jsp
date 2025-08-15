<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.example.jdbc.entity.Product" %>
<%
    Product p = (Product) request.getAttribute("product");
%>
<html>
<head><title>Chi tiết sản phẩm</title></head>
<body>
<h2>Chi tiết sản phẩm</h2>
<% if (p != null) { %>
<p><b>ID:</b> <%= p.getId() %></p>
<p><b>Tên:</b> <%= p.getName() %></p>
<p><b>Giá (VND):</b> <%= String.format("%,d", p.getPrice()) %></p>
<p><b>Số lượng:</b> <%= p.getQuantity() %></p>

<p>
    <a href="${pageContext.request.contextPath}/products?action=edit&id=<%=p.getId()%>">Sửa</a> |
    <a href="${pageContext.request.contextPath}/products?action=list">Về danh sách</a>
</p>
<% } else { %>
<p>Không tìm thấy sản phẩm.</p>
<a href="${pageContext.request.contextPath}/products?action=list">Về danh sách</a>
<% } %>
</body>
</html>
