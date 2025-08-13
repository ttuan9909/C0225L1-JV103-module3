<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,com.example.demo_mvc.entity.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    String q = (String) request.getAttribute("q");
%>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <style>
        table { border-collapse: collapse; width: 100% }
        th, td { border: 1px solid #ccc; padding: 8px; }
        .actions a { margin-right: 6px; }
        form.inline { display:inline-block }
    </style>
</head>
<body>
<h2>Danh sách sản phẩm</h2>

<form method="get" action="${pageContext.request.contextPath}/products" class="inline">
    <input type="hidden" name="action" value="search"/>
    <input name="q" value="<%= q %>" placeholder="Tìm theo tên..."/>
    <button type="submit">Tìm</button>
</form>
<a href="${pageContext.request.contextPath}/products?action=list">Xoá lọc</a>
|
<a href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>

<table>
    <thead>
    <tr>
        <th>ID</th><th>Tên</th><th>Giá (VND)</th><th>Số lượng</th><th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (products != null && !products.isEmpty()) {
            for (Product p : products) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/products?action=view&id=<%=p.getId()%>">
                <%= p.getName() %>
            </a>
        </td>
        <td><%= String.format("%,d", p.getPrice()) %></td>
        <td><%= p.getQuantity() %></td>
        <td class="actions">
            <a href="${pageContext.request.contextPath}/products?action=edit&id=<%=p.getId()%>">Sửa</a>
            <a href="${pageContext.request.contextPath}/products?action=delete&id=<%=p.getId()%>"
               onclick="return confirm('Xoá sản phẩm này?')">Xoá</a>
        </td>
    </tr>
    <%      }
    } else { %>
    <tr><td colspan="5">Không có dữ liệu.</td></tr>
    <% } %>
    </tbody>
</table>
</body>
</html>
