<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head><title>Chi tiết sản phẩm</title></head>
<body>
<h2>Chi tiết sản phẩm</h2>

<c:choose>
    <c:when test="${not empty product}">
        <p><b>ID:</b> ${product.id}</p>
        <p><b>Tên:</b> ${product.name}</p>
        <p><b>Giá (VND):</b> <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/></p>
        <p><b>Số lượng:</b> ${product.quantity}</p>
        <p><b>Danh mục:</b> <c:out value="${empty product.categoryName ? '(Chưa gán)' : product.categoryName}"/></p>

        <p>
            <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Sửa</a> |
            <a href="${pageContext.request.contextPath}/products?action=list">Về danh sách</a>
        </p>
    </c:when>
    <c:otherwise>
        <p>Không tìm thấy sản phẩm.</p>
        <a href="${pageContext.request.contextPath}/products?action=list">Về danh sách</a>
    </c:otherwise>
</c:choose>
</body>
</html>
