<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"
            ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Borrow Management - The Knowledge Nexus</title>
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
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
                                <a href="${pageContext.request.contextPath}/admin/users"><i
                                        class="ri-user-settings-line"></i> Users</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/books"><i class="ri-book-3-line"></i>
                                    Inventory</a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="active"><i class="ri-exchange-line"></i> Circulation</a>
                            </li>
                            <li class="nav-item" style="margin-top: auto;">
                                <a href="${pageContext.request.contextPath}/logout"><i
                                        class="ri-logout-box-r-line"></i> Logout</a>
                            </li>
                        </ul>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">

                        <header class="header-bar">
                            <div>
                                <h1 style="font-size: 2rem;">Circulation</h1>
                                <p style="color: var(--text-secondary);">Track active and returned loans.</p>
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

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger"><i class="ri-error-warning-line"></i>
                                <c:out value="${error}" />
                            </div>
                        </c:if>

                        <div class="glass-panel">
                            <table class="premium-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Borrower</th>
                                        <th>Book Details</th>
                                        <th>Dates</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty borrows}">
                                            <c:forEach var="borrow" items="${borrows}">
                                                <tr>
                                                    <td style="color: var(--text-muted);">#${borrow.id}</td>
                                                    <td>
                                                        <c:set var="userId" value="${borrow.userId}" />
                                                        <c:choose>
                                                            <c:when test="${userMap.containsKey(userId)}">
                                                                <div
                                                                    style="font-weight: 600; color: var(--text-primary);">
                                                                    ${userMap.get(userId).username}</div>
                                                                <div
                                                                    style="font-size: 0.85rem; color: var(--text-secondary);">
                                                                    ${userMap.get(userId).email}</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: var(--text-muted);">User
                                                                    #${userId}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; align-items: center; gap: 16px;">
                                                            <div style="width: 45px; height: 68px; border-radius: 6px; overflow: hidden; background: rgba(255,255,255,0.05); flex-shrink: 0;">
                                                                <c:choose>
                                                                    <c:when test="${borrow.book != null}">
                                                                         <img src="https://covers.openlibrary.org/b/isbn/${borrow.book.isbn}-S.jpg?default=false" 
                                                                             alt="Cover" 
                                                                             style="width: 100%; height: 100%; object-fit: cover;"
                                                                             onerror="this.style.display='none'; this.parentNode.innerHTML='<div style=\'width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);\'><i class=\'ri-book-line\'></i></div>';">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                         <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);"><i class="ri-book-line"></i></div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div>
                                                                <div style="font-weight: 600; color: var(--text-primary);">
                                                                    ${borrow.bookTitle}</div>
                                                                <div style="font-size: 0.85rem; color: var(--text-secondary);">
                                                                    by ${borrow.bookAuthor}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div style="font-size: 0.9rem;">
                                                            <div style="margin-bottom: 2px;"><span
                                                                    style="color: var(--text-muted);">Out:</span>
                                                                ${borrow.borrowDate}</div>
                                                            <div><span style="color: var(--text-muted);">Due:</span>
                                                                ${borrow.returnDate}</div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${borrow.returned || borrow.returnDate != null ? 'badge-success' : 'badge-warning'}">
                                                            ${borrow.returned || borrow.returnDate != null ? 'Returned' : 'Active Loan'}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5"
                                                    style="text-align:center; padding: 40px; color:var(--text-muted);">
                                                    <i class="ri-inbox-archive-line"
                                                        style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                                    No borrowing history found.
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