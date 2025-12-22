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
    <title>Add Book - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>body { justify-content: center; align-items: center; }</style>
</head>
<body>
    <div class="container">
        <h1>Add New Book</h1>
        <p>Expand the library collection.</p>

        <form action="${pageContext.request.contextPath}/admin/books" method="post">
            <input type="hidden" name="action" value="create">
            
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" required placeholder="Book Title">
            </div>
            <div class="form-group">
                <label for="author">Author</label>
                <input type="text" id="author" name="author" required placeholder="Author Name">
            </div>
            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input type="text" id="isbn" name="isbn" required placeholder="ISBN Number">
            </div>
            <div class="form-group">
                <label for="copies">Available Copies</label>
                <input type="number" id="copies" name="copies" required min="1" value="1" class="search-input" style="border-radius:12px;">
            </div>

            <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                <button type="submit" class="btn btn-primary" style="flex:1;">Add Book</button>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary" style="flex:1;">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
