<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>Category List</h2>

<form action="${pageContext.request.contextPath}/categories" method="get">
    <input type="hidden" name="action" value="search"/>
    <input type="text" name="q" value="${q}" placeholder="Tìm theo tên..."/>
    <button type="submit">Search</button>
    <a href="${pageContext.request.contextPath}/categories?action=create">+ New</a>
</form>

<table border="1" cellpadding="8" cellspacing="0">
    <thead>
    <tr><th>ID</th><th>Name</th><th>Actions</th></tr>
    </thead>
    <tbody>
    <c:forEach var="c" items="${categories}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>
                <a href="${pageContext.request.contextPath}/categories?action=view&id=${c.id}">View</a> |
                <a href="${pageContext.request.contextPath}/categories?action=edit&id=${c.id}">Edit</a> |
                <a href="${pageContext.request.contextPath}/categories?action=delete&id=${c.id}" onclick="return confirm('Xóa danh mục này?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
