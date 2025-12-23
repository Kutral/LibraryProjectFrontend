<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"
            ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Book Management - The Knowledge Nexus</title>
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
            </head>

            <body>

                <div class="dashboard-layout">
                    <!-- Conditional Sidebar -->
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'ADMIN'}">
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
                                        <a href="#" class="active"><i class="ri-book-3-line"></i> Inventory</a>
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
                        </c:when>
                        <c:otherwise>
                            <aside class="sidebar">
                                <div class="sidebar-brand">
                                    <i class="ri-shining-2-fill"></i> Nexus
                                </div>
                                <ul class="nav-links">
                                    <li class="nav-item">
                                        <a href="${pageContext.request.contextPath}/dashboard"><i
                                                class="ri-dashboard-line"></i> Discover</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="${pageContext.request.contextPath}/globalSearch"><i
                                                class="ri-earth-line"></i> Global Search</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="${pageContext.request.contextPath}/myBooks"><i
                                                class="ri-book-3-line"></i> My Books</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="${pageContext.request.contextPath}/requests"><i
                                                class="ri-git-pull-request-line"></i> My Requests</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="${pageContext.request.contextPath}/jsp/userHistory.jsp"><i
                                                class="ri-history-line"></i> History</a>
                                    </li>
                                    <li class="nav-item" style="margin-top: auto;">
                                        <a href="${pageContext.request.contextPath}/index.jsp"><i
                                                class="ri-logout-box-r-line"></i> Logout</a>
                                    </li>
                                </ul>
                            </aside>
                        </c:otherwise>
                    </c:choose>

                    <!-- Main Content -->
                    <main class="main-content">

                        <header class="header-bar">
                            <div>
                                <h1 style="font-size: 2rem;">Library Inventory</h1>
                                <p style="color: var(--text-secondary);">Browse and manage the collection.</p>
                            </div>
                            <div style="display: flex; align-items: center; gap: 24px;">
                                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/jsp/addBook.jsp"
                                        class="btn btn-primary" style="padding: 10px 20px;">
                                        <i class="ri-add-line"></i> Add Book
                                    </a>
                                </c:if>
                                <div class="user-profile">
                                    <div style="text-align: right;">
                                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                                        <div style="font-size: 0.8rem; color: var(--text-muted);">${sessionScope.user.role == 'ADMIN' ? 'Administrator' : 'Standard Member'}</div>
                                    </div>
                                    <div class="avatar-circle">
                                        ${sessionScope.user.username.charAt(0)}
                                    </div>
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
                                        <th>Book Details</th>
                                        <th>ISBN</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty books}">
                                            <c:forEach var="book" items="${books}">
                                                <tr>
                                                    <td style="color: var(--text-muted);">#${book.id}</td>
                                                    <td>
                                                        <div style="display: flex; align-items: center; gap: 16px;">
                                                            <div style="width: 45px; height: 68px; border-radius: 6px; overflow: hidden; background: rgba(255,255,255,0.05); flex-shrink: 0;">
                                                                <img src="https://covers.openlibrary.org/b/isbn/${book.isbn}-S.jpg?default=false" 
                                                                     alt="Cover" 
                                                                     style="width: 100%; height: 100%; object-fit: cover;"
                                                                     onerror="this.style.display='none'; this.parentNode.innerHTML='<div style=\'width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);\'><i class=\'ri-book-line\'></i></div>';">
                                                            </div>
                                                            <div>
                                                                <div style="font-weight: 600; color: var(--text-primary); font-size: 1rem;">
                                                                    ${book.title}</div>
                                                                <div style="font-size: 0.85rem; color: var(--text-secondary);">
                                                                    by ${book.author}</div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td
                                                        style="font-family: monospace; letter-spacing: 0.5px; color: var(--text-muted);">
                                                        ${book.isbn}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${book.availableCopies > 0}">
                                                                <span
                                                                    class="badge badge-success">${book.availableCopies}
                                                                    Available</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-error">Out of Stock</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                                <div style="display: flex; gap: 8px;">
                                                                    <a href="${pageContext.request.contextPath}/jsp/editBook.jsp?id=${book.id}&title=${book.title}&author=${book.author}&isbn=${book.isbn}&copies=${book.availableCopies}"
                                                                        class="btn btn-secondary"
                                                                        style="padding: 8px 12px;">
                                                                        <i class="ri-pencil-line"></i>
                                                                    </a>

                                                                    <form
                                                                        action="${pageContext.request.contextPath}/admin/books"
                                                                        method="post"
                                                                        onsubmit="return confirm('Are you sure you want to delete this book?');"
                                                                        style="margin:0;">
                                                                        <input type="hidden" name="action"
                                                                            value="delete">
                                                                        <input type="hidden" name="id"
                                                                            value="${book.id}">
                                                                        <button type="submit" class="btn btn-danger"
                                                                            style="padding: 8px 12px;">
                                                                            <i class="ri-delete-bin-line"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${book.availableCopies > 0}">
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/borrowBook"
                                                                            method="post" style="margin:0;">
                                                                            <input type="hidden" name="bookId"
                                                                                value="${book.id}">
                                                                            <button type="submit"
                                                                                class="btn btn-primary"
                                                                                style="padding: 8px 16px;">
                                                                                Borrow
                                                                            </button>
                                                                        </form>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button class="btn btn-secondary" disabled
                                                                            style="padding: 8px 16px; opacity: 0.5; cursor: not-allowed;">
                                                                            Unavailable
                                                                        </button>
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
                                                <td colspan="5"
                                                    style="text-align:center; padding: 40px; color:var(--text-muted);">
                                                    <i class="ri-book-open-line"
                                                        style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                                    The library is currently empty.
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