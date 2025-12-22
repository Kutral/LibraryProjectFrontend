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
    <title>Edit User - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>body { justify-content: center; align-items: center; }</style>
</head>
<body>
    <div class="container">
        <h1>Edit User</h1>
        <p>Manage user credentials.</p>

        <form action="${pageContext.request.contextPath}/admin/users" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${param.id}">
            
            <div class="form-group">
                <label>Username</label>
                <input type="text" value="${param.username}" disabled style="opacity: 0.7; cursor: not-allowed;">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required value="${param.email}">
            </div>
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" class="search-input" style="border-radius:12px;">
                    <option value="USER" ${param.role == 'USER' ? 'selected' : ''}>User</option>
                    <option value="ADMIN" ${param.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                </select>
            </div>

            <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                <button type="submit" class="btn btn-primary" style="flex:1;">Update User</button>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary" style="flex:1;">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
