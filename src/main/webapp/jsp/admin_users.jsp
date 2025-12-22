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
    <title>User Management - The Knowledge Nexus</title>
    <!-- Use timestamp to bust cache -->
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
                <h1>Registered Users</h1>
                <p>Manage user access and details.</p>
            </div>
            <a href="${pageContext.request.contextPath}/jsp/adminDashboard.jsp" class="btn">Back to Dashboard</a>
        </div>

        <c:if test="${not empty param.error}">
            <div class="alert alert-danger"><c:out value="${param.error}"/></div>
        </c:if>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Joined On</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty users}">
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>#${user.id}</td>
                                    <td style="font-weight: 500; color: var(--text-main);">${user.username}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <span class="badge ${user.role == 'ADMIN' ? 'badge-available' : 'badge-out'}" 
                                              style="${user.role == 'USER' ? 'background:rgba(79, 172, 254, 0.2); color:var(--primary-color); border-color:rgba(79, 172, 254, 0.4);' : ''}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>${user.createdAt}</td>
                                    <td style="display:flex; align-items:center;">
                                        <a href="${pageContext.request.contextPath}/jsp/editUser.jsp?id=${user.id}&username=${user.username}&email=${user.email}&role=${user.role}" 
                                           class="action-btn btn-edit">Edit</a>
                                        
                                        <form action="${pageContext.request.contextPath}/admin/users" method="post" onsubmit="return confirm('Are you sure you want to remove this user?');" style="margin:0;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${user.id}">
                                            <button type="submit" class="action-btn btn-delete" style="cursor:pointer;">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="empty-state" style="background: transparent;">No users found in the system.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
    </div>

</body>
</html>