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
    <title>Borrow Management - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/jsp/adminDashboard.jsp" class="navbar-brand">
            <span>🛡️</span> 
            <span>Admin Portal</span>
        </a>
        <div class="navbar-user">
            <span>Administrator</span>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="dashboard-container" style="display: block; max-width: 1000px;">
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <div>
                <h1>All Borrows</h1>
                <p>View and track book circulation history.</p>
            </div>
            <a href="${pageContext.request.contextPath}/jsp/adminDashboard.jsp" class="btn">Back to Dashboard</a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger"><c:out value="${error}"/></div>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Book</th>
                        <th>Borrow Date</th>
                        <th>Due Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty borrows}">
                            <c:forEach var="borrow" items="${borrows}">
                                <tr>
                                    <td>#${borrow.id}</td>
                                    <td>
                                        <c:set var="userId" value="${borrow.userId}"/>
                                        <c:choose>
                                            <c:when test="${userMap.containsKey(userId)}">
                                                <div style="font-weight: 500;">${userMap.get(userId).username}</div>
                                                <div style="font-size: 0.8em; opacity: 0.7;">${userMap.get(userId).email}</div>
                                            </c:when>
                                            <c:otherwise>
                                                User #${userId}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="font-weight: 500;">${borrow.bookTitle}</div>
                                        <div style="font-size: 0.8em; opacity: 0.7;">${borrow.bookAuthor}</div>
                                    </td>
                                    <td>${borrow.borrowDate}</td>
                                    <td>${borrow.returnDate}</td>
                                    <td>
                                        <span class="badge ${borrow.returned ? 'badge-available' : 'badge-out'}">
                                            ${borrow.returned ? 'Returned' : 'Borrowed'}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="empty-state" style="background: transparent;">No borrow records found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
    </div>

</body>
</html>
