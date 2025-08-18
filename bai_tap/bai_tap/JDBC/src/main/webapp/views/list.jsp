<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <input name="q" value="${q}" placeholder="Tìm theo tên..."/>
    <button type="submit">Tìm</button>
</form>
<a href="${pageContext.request.contextPath}/products?action=list">Xoá lọc</a>
|
<a href="${pageContext.request.contextPath}/products?action=create">+ Thêm sản phẩm</a>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Giá (VND)</th>
        <th>Số lượng</th>
        <th>Danh mục</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="p" items="${products}">
        <tr>
            <td>${p.id}</td>
            <td>
                <a href="${pageContext.request.contextPath}/products?action=view&id=${p.id}">
                        ${p.name}
                </a>
            </td>
            <td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/></td>
            <td>${p.quantity}</td>
            <td>
                <c:choose>
                    <c:when test="${empty p.categoryName}">(Chưa gán)</c:when>
                    <c:otherwise>${p.categoryName}</c:otherwise>
                </c:choose>
            </td>
            <td class="actions">
                <a href="${pageContext.request.contextPath}/products?action=edit&id=${p.id}">Sửa</a>
                <a href="${pageContext.request.contextPath}/products?action=delete&id=${p.id}"
                   onclick="return confirm('Xoá sản phẩm này?')">Xoá</a>
            </td>
        </tr>
    </c:forEach>
    <c:if test="${empty products}">
        <tr><td colspan="6">Không có dữ liệu.</td></tr>
    </c:if>
    </tbody>
</table>
</body>
</html>
