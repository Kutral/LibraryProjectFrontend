<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Requests - The Knowledge Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="dashboard-layout">
        <aside class="sidebar">
            <div class="sidebar-brand">
                <i class="ri-shining-2-fill"></i> Nexus
            </div>
            <ul class="nav-links">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard"><i class="ri-dashboard-line"></i> Discover</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/globalSearch"><i class="ri-earth-line"></i> Global Search</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/myBooks"><i class="ri-book-3-line"></i> My Books</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="active"><i class="ri-git-pull-request-line"></i> My Requests</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/history"><i class="ri-history-line"></i> History</a>
                </li>
                <li class="nav-item" style="margin-top: auto;">
                    <a href="${pageContext.request.contextPath}/logout"><i class="ri-logout-box-r-line"></i> Logout</a>
                </li>
            </ul>
        </aside>

        <main class="main-content">
            <header class="header-bar">
                <div>
                    <h1 style="font-size: 2rem;">My Requests</h1>
                    <p style="color: var(--text-secondary);">Track books you've asked to be added.</p>
                </div>
                <div class="user-profile">
                    <div style="text-align: right;">
                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                        <div style="font-size: 0.8rem; color: var(--text-muted);">Standard Member</div>
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
                            <th>Book Details</th>
                            <th>ISBN</th>
                            <th>Requested On</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty bookRequests}">
                                <c:forEach var="req" items="${bookRequests}">
                                    <tr>
                                        <td>
                                            <div style="display: flex; align-items: center; gap: 16px;">
                                                <div style="width: 40px; height: 60px; border-radius: 4px; overflow: hidden; background: rgba(255,255,255,0.05); flex-shrink: 0; display:flex; align-items:center; justify-content:center; color: var(--text-muted);">
                                                    <i class="ri-book-line"></i>
                                                </div>
                                                <div>
                                                    <div style="font-weight: 600; color: var(--text-primary);">${req.title}</div>
                                                    <div style="font-size: 0.85rem; color: var(--text-secondary);">by ${req.author}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="font-family: monospace;">${req.isbn}</td>
                                        <td style="color: var(--text-secondary);">${req.requestDate}</td>
                                        <td>
                                            <span class="badge ${req.status == 'APPROVED' ? 'badge-success' : (req.status == 'REJECTED' ? 'badge-danger' : 'badge-warning')}">
                                                ${req.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" style="text-align:center; padding: 40px; color:var(--text-muted);">
                                        <i class="ri-inbox-line" style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                        You haven't requested any books yet.
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
