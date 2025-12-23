<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"
            ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>User Management - The Knowledge Nexus</title>
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
                <!-- Use timestamp to bust cache -->
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
            </head>

            <body>

                <div class="dashboard-layout">
                    <!-- Sidebar -->
                    <aside class="sidebar">
                        <div class="sidebar-brand">
                            <i class="ri-shield-star-fill"></i> Admin
                        </div>
                        <ul class="nav-links">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/dashboard"><i
                                        class="ri-home-4-line"></i> Overview</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/globalSearch"><i
                                        class="ri-earth-line"></i> Global Search</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/requests"><i
                                        class="ri-git-pull-request-line"></i> Requests</a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="active"><i class="ri-user-settings-line"></i> Users</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/books"><i class="ri-book-3-line"></i>
                                    Inventory</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/borrows"><i
                                        class="ri-exchange-line"></i> Circulation</a>
                            </li>
                            <li class="nav-item" style="margin-top: auto;">
                                <a href="${pageContext.request.contextPath}/index.jsp"><i
                                        class="ri-logout-box-r-line"></i> Logout</a>
                            </li>
                        </ul>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">

                        <header class="header-bar">
                            <div>
                                <h1 style="font-size: 2rem;">User Registry</h1>
                                <p style="color: var(--text-secondary);">Manage account permissions.</p>
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

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger"><i class="ri-error-warning-line"></i>
                                <c:out value="${param.error}" />
                            </div>
                        </c:if>

                        <c:if test="${not empty param.msg}">
                            <div class="alert alert-success">
                                <i class="ri-checkbox-circle-line"></i>
                                <c:out value="${param.msg}" />
                            </div>
                        </c:if>

                        <div class="glass-panel">
                            <table class="premium-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Identity</th>
                                        <th>Role</th>
                                        <th>Joined</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td style="color: var(--text-muted);">#${user.id}</td>
                                                    <td>
                                                        <div style="font-weight: 600; color: var(--text-primary);">
                                                            ${user.username}</div>
                                                        <div style="font-size: 0.85rem; color: var(--text-secondary);">
                                                            ${user.email}</div>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${user.role == 'ADMIN' ? 'badge-warning' : 'badge-success'}">
                                                            ${user.role}
                                                        </span>
                                                    </td>
                                                    <td style="color: var(--text-secondary);">${user.createdAt}</td>
                                                    <td>
                                                        <div style="display: flex; gap: 8px;">
                                                            <a href="${pageContext.request.contextPath}/jsp/editUser.jsp?id=${user.id}&username=${user.username}&email=${user.email}&role=${user.role}"
                                                                class="btn btn-secondary" style="padding: 8px 12px;">
                                                                <i class="ri-pencil-line"></i>
                                                            </a>

                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/users"
                                                                method="post"
                                                                onsubmit="return confirm('Are you sure you want to remove this user?');"
                                                                style="margin:0;">
                                                                <input type="hidden" name="action" value="delete">
                                                                <input type="hidden" name="id" value="${user.id}">
                                                                <button type="submit" class="btn btn-danger"
                                                                    style="padding: 8px 12px;">
                                                                    <i class="ri-delete-bin-line"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5"
                                                    style="text-align:center; padding: 40px; color:var(--text-muted);">
                                                    <i class="ri-user-unfollow-line"
                                                        style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                                    No users found.
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