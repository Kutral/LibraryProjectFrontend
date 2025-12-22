<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("user") == null || !"ADMIN".equalsIgnoreCase(((com.eswar.library.model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>body { justify-content: center; align-items: center; }</style>
</head>
<body>
    <div class="container">
        <h1>Edit Book</h1>
        <p>Update book details.</p>

        <form action="${pageContext.request.contextPath}/admin/books" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${param.id}">
            
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" required value="${param.title}">
            </div>
            <div class="form-group">
                <label for="author">Author</label>
                <input type="text" id="author" name="author" required value="${param.author}">
            </div>
            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input type="text" id="isbn" name="isbn" required value="${param.isbn}">
            </div>
            <div class="form-group">
                <label for="copies">Available Copies</label>
                <input type="number" id="copies" name="copies" required min="0" value="${param.copies}" class="search-input" style="border-radius:12px;">
            </div>

            <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                <button type="submit" class="btn btn-primary" style="flex:1;">Save Changes</button>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary" style="flex:1;">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
