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
                                        <a href="${pageContext.request.contextPath}/logout"><i
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
                                        <a href="${pageContext.request.contextPath}/logout"><i
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

                        <div class="content-grid" style="grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));">
                            <c:choose>
                                <c:when test="${not empty books}">
                                    <c:forEach var="book" items="${books}">
                                        <div class="glass-panel" style="padding: 0; display: flex; height: 200px; transition: transform 0.3s ease; border: 1px solid var(--glass-border); overflow: hidden; position: relative;">
                                            <!-- Cover Section -->
                                            <div style="width: 130px; background: rgba(0,0,0,0.3); border-right: 1px solid var(--glass-border); position: relative;">
                                                <img src="https://covers.openlibrary.org/b/isbn/${book.isbn}-M.jpg?default=false" 
                                                     alt="Cover" 
                                                     style="width: 100%; height: 100%; object-fit: cover;"
                                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                    <i class="ri-book-3-line"></i>
                                                </div>
                                            </div>

                                            <!-- Info Section -->
                                            <div style="padding: 20px; flex: 1; display: flex; flex-direction: column; min-width: 0;">
                                                <div style="font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="${book.title}">
                                                    ${book.title}
                                                </div>
                                                <div style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 8px;">
                                                    by ${book.author}
                                                </div>
                                                
                                                <div style="font-size: 0.8rem; color: var(--text-muted); margin-bottom: 12px; font-family: monospace;">
                                                    ISBN: ${book.isbn}
                                                </div>

                                                <div style="margin-top: auto;">
                                                    <c:choose>
                                                        <c:when test="${book.availableCopies > 0}">
                                                            <div style="margin-bottom: 12px; font-size: 0.8rem; color: var(--status-success); display: flex; align-items: center; gap: 6px;">
                                                                <i class="ri-checkbox-circle-line"></i> ${book.availableCopies} Available
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div style="margin-bottom: 12px; font-size: 0.8rem; color: var(--status-danger); display: flex; align-items: center; gap: 6px;">
                                                                <i class="ri-close-circle-line"></i> Out of Stock
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <c:choose>
                                                        <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                            <div style="display: flex; gap: 8px;">
                                                                <a href="${pageContext.request.contextPath}/jsp/editBook.jsp?id=${book.id}&title=${book.title}&author=${book.author}&isbn=${book.isbn}&copies=${book.availableCopies}"
                                                                    class="btn btn-secondary"
                                                                    style="padding: 8px 12px; flex: 1; justify-content: center;">
                                                                    <i class="ri-pencil-line"></i>
                                                                </a>

                                                                <form
                                                                    action="${pageContext.request.contextPath}/admin/books"
                                                                    method="post"
                                                                    onsubmit="return confirm('Are you sure you want to delete this book?');"
                                                                    style="margin:0; flex: 1;">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="id" value="${book.id}">
                                                                    <button type="submit" class="btn btn-danger"
                                                                        style="padding: 8px 12px; width: 100%; justify-content: center;">
                                                                        <i class="ri-delete-bin-line"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:choose>
                                                                <c:when test="${book.availableCopies > 0}">
                                                                    <form action="${pageContext.request.contextPath}/borrowBook" method="post" style="margin:0;">
                                                                        <input type="hidden" name="bookId" value="${book.id}">
                                                                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 8px; font-size: 0.9rem; justify-content: center;">
                                                                            Borrow
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-secondary" disabled style="width: 100%; padding: 8px; font-size: 0.9rem; opacity: 0.5; cursor: not-allowed; justify-content: center;">
                                                                        Unavailable
                                                                    </button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="glass-panel" style="padding: 60px; text-align: center; grid-column: 1/-1;">
                                        <i class="ri-book-open-line" style="font-size: 2rem; display:block; margin-bottom:10px; color: var(--text-muted);"></i>
                                        <p style="color: var(--text-muted);">The library is currently empty.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </main>
                </div>

            </body>

            </html>