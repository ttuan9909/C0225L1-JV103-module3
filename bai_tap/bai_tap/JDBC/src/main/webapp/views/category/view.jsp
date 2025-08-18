<%@ page contentType="text/html; charset=UTF-8" %>
<h2>Category Detail</h2>
<p><b>ID:</b> ${category.id}</p>
<p><b>Name:</b> ${category.name}</p>
<p>
    <a href="${pageContext.request.contextPath}/categories?action=edit&id=${category.id}">Edit</a> |
    <a href="${pageContext.request.contextPath}/categories?action=list">Back</a>
</p>
