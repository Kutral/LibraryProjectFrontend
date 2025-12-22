<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="#" class="navbar-brand">
            <span>🛡️</span> 
            <span>Admin Portal</span>
        </a>
        <div class="navbar-user">
            <span>Administrator</span>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container" style="max-width: 800px; margin-top: 3rem;">
        <h1>Admin Dashboard</h1>
        <p>Manage system resources and user access.</p>
        
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
            <div class="book-card" style="text-align: center; border-color: var(--glass-border);">
                <div class="book-icon" style="background: none; -webkit-background-clip: unset; color: var(--secondary-color);">👥</div>
                <div class="book-title">User Management</div>
                <p>View, edit, or remove registered users.</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary" style="width: 100%; margin-top: auto;">Manage Users</a>
            </div>
            
            <div class="book-card" style="text-align: center; border-color: var(--glass-border);">
                <div class="book-icon" style="background: none; -webkit-background-clip: unset; color: var(--warning-color);">📚</div>
                <div class="book-title">Book Inventory</div>
                <p>Add new books, update stock, or remove titles.</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary" style="width: 100%; margin-top: auto;">Manage Books</a>
            </div>
        </div>

    </div>

</body>
</html>
