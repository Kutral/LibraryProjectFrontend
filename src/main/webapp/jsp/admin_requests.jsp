<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Requests - The Knowledge Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-brand">
                <i class="ri-shield-star-fill"></i> Admin
            </div>
            <ul class="nav-links">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="ri-home-4-line"></i> Overview</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/globalSearch"><i class="ri-earth-line"></i> Global Search</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="active"><i class="ri-git-pull-request-line"></i> Requests</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/admin/users"><i class="ri-user-settings-line"></i> Users</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/books"><i class="ri-book-mark-line"></i> Inventory</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/admin/borrows"><i class="ri-exchange-line"></i> Circulation</a>
                </li>
                <li class="nav-item" style="margin-top: auto;">
                    <a href="${pageContext.request.contextPath}/logout"><i class="ri-logout-box-r-line"></i> Logout</a>
                </li>
            </ul>
        </aside>

        <main class="main-content">
            <header class="header-bar">
                <div>
                    <h1 style="font-size: 2rem;">Book Requests</h1>
                    <p style="color: var(--text-secondary);">Approve or reject community requests.</p>
                </div>
                <div class="user-profile">
                    <div style="text-align: right;">
                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                        <div style="font-size: 0.8rem; color: var(--text-muted);">Administrator</div>
                    </div>
                    <div class="avatar-circle">
                        ${sessionScope.user.username.charAt(0)}
                    </div>
                </div>
            </header>

            <c:if test="${not empty param.msg}">
                <div class="alert alert-success"><i class="ri-checkbox-circle-line"></i> ${param.msg}</div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger"><i class="ri-error-warning-line"></i> ${param.error}</div>
            </c:if>

            <div class="glass-panel">
                <table class="premium-table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Book Details</th>
                            <th>ISBN</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty bookRequests}">
                                <c:forEach var="req" items="${bookRequests}">
                                    <tr>
                                        <td>
                                            <div style="font-weight: 600;">${req.username}</div>
                                            <div style="font-size: 0.8rem; color: var(--text-muted);">ID: #${req.userId}</div>
                                        </td>
                                        <td>
                                            <div style="font-weight: 600; color: var(--text-primary);">${req.title}</div>
                                            <div style="font-size: 0.85rem; color: var(--text-secondary);">by ${req.author}</div>
                                        </td>
                                        <td style="font-family: monospace;">${req.isbn}</td>
                                        <td>
                                            <span class="badge ${req.status == 'APPROVED' ? 'badge-success' : (req.status == 'REJECTED' ? 'badge-danger' : 'badge-warning')}">
                                                ${req.status}
                                            </span>
                                        </td>
                                        <td>
                                            <c:if test="${req.status == 'PENDING'}">
                                                <div style="display: flex; gap: 8px;">
                                                    <form action="${pageContext.request.contextPath}/requests" method="post" style="margin:0;">
                                                        <input type="hidden" name="action" value="approve">
                                                        <input type="hidden" name="requestId" value="${req.id}">
                                                        <button type="submit" class="btn btn-primary" style="padding: 8px 12px; font-size: 0.8rem;">Approve</button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/requests" method="post" style="margin:0;">
                                                        <input type="hidden" name="action" value="reject">
                                                        <input type="hidden" name="requestId" value="${req.id}">
                                                        <button type="submit" class="btn btn-danger" style="padding: 8px 12px; font-size: 0.8rem;">Reject</button>
                                                    </form>
                                                </div>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" style="text-align:center; padding: 40px; color:var(--text-muted);">
                                        <i class="ri-mail-open-line" style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                        No pending requests found.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
