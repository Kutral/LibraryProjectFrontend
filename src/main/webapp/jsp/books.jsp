<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Management - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="${sessionScope.user.role == 'ADMIN' ? pageContext.request.contextPath.concat('/jsp/adminDashboard.jsp') : pageContext.request.contextPath.concat('/dashboard')}" class="navbar-brand">
            <span>📚</span> 
            <span>${sessionScope.user.role == 'ADMIN' ? 'Admin Portal' : 'Library Catalog'}</span>
        </a>
        <div class="navbar-user">
            <span>Welcome, <strong>${sessionScope.user.username}</strong></span>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="dashboard-container" style="display: block; max-width: 1100px;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <div>
                <h1>Library Inventory</h1>
                <p>Browse and manage the collection of wisdom.</p>
            </div>
            <div style="display: flex; gap: 1rem;">
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/jsp/addBook.jsp" class="btn btn-primary">Add New Book</a>
                </c:if>
                <a href="${sessionScope.user.role == 'ADMIN' ? pageContext.request.contextPath.concat('/jsp/adminDashboard.jsp') : pageContext.request.contextPath.concat('/dashboard')}" class="btn">Back</a>
            </div>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger"><c:out value="${param.error}"/></div>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Book Details</th>
                        <th>ISBN</th>
                        <th>Availability</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty books}">
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>#${book.id}</td>
                                    <td>
                                        <div style="font-weight: 600; color: var(--text-main); font-size: 1.05rem;">${book.title}</div>
                                        <div style="font-size: 0.85rem; color: var(--text-muted);">by ${book.author}</div>
                                    </td>
                                    <td style="font-family: monospace;">${book.isbn}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${book.availableCopies > 0}">
                                                <span class="badge badge-available">${book.availableCopies} Copies Available</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-out">Out of Stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex; align-items:center;">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                <a href="${pageContext.request.contextPath}/jsp/editBook.jsp?id=${book.id}&title=${book.title}&author=${book.author}&isbn=${book.isbn}&copies=${book.availableCopies}" 
                                                   class="action-btn btn-edit">Edit</a>
                                                
                                                <form action="${pageContext.request.contextPath}/admin/books" method="post" onsubmit="return confirm('Are you sure you want to delete this book?');" style="margin:0;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${book.id}">
                                                    <button type="submit" class="action-btn btn-delete" style="cursor:pointer;">Remove</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${book.availableCopies > 0}">
                                                        <form action="${pageContext.request.contextPath}/borrowBook" method="post" style="margin:0;">
                                                            <input type="hidden" name="bookId" value="${book.id}">
                                                            <button type="submit" class="btn btn-primary" style="padding: 0.4rem 1rem; font-size: 0.85rem;">Borrow</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn" disabled style="padding: 0.4rem 1rem; font-size: 0.85rem; opacity: 0.5;">Reserved</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty-state" style="background: transparent;">No books are currently available in the inventory.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
    </div>

</body>
</html>