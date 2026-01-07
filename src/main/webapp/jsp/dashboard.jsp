<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath()
                + "/jsp/login.jsp" ); return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Dashboard - The Knowledge Nexus</title>
                    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
                </head>

                <body>

                    <div class="dashboard-layout">
                        <!-- Sidebar -->
                        <aside class="sidebar">
                            <div class="sidebar-brand">
                                <i class="ri-shining-2-fill"></i> Nexus
                            </div>
                            <ul class="nav-links">
                                <li class="nav-item">
                                    <a href="#" class="active"><i class="ri-dashboard-line"></i> Discover</a>
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
                                    <a href="${pageContext.request.contextPath}/history"><i
                                            class="ri-history-line"></i> History</a>
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
                                    <h1 style="font-size: 2rem;">Library Catalog</h1>
                                    <p style="color: var(--text-secondary);">Explore a universe of knowledge.</p>
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
                                <div class="alert alert-success">
                                    <i class="ri-checkbox-circle-line"></i>
                                    <c:out value="${param.msg}" />
                                </div>
                            </c:if>

                            <div class="form-group" style="max-width: 400px; margin-bottom: 40px;">
                                <form action="${pageContext.request.contextPath}/dashboard" method="GET"
                                    style="position:relative;">
                                    <i class="ri-search-2-line"
                                        style="position:absolute; left:16px; top:18px; color:var(--text-secondary);"></i>
                                    <input type="text" name="query" placeholder="Search titles, authors..."
                                        value="${searchQuery}"
                                        style="padding-left: 48px; background: rgba(255,255,255,0.05);">
                                </form>
                            </div>

                            <div class="content-grid" style="grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));">
                                <c:choose>
                                    <c:when test="${not empty books}">
                                        <c:forEach var="book" items="${books}">
                                            <div class="glass-panel" style="padding: 0; display: flex; height: 200px; transition: transform 0.3s ease; border: 1px solid var(--glass-border); overflow: hidden; position: relative;">
                                                <!-- Cover Section -->
                                                <div style="width: 130px; background: rgba(0,0,0,0.3); border-right: 1px solid var(--glass-border); position: relative;">
                                                    <img src="https://covers.openlibrary.org/b/isbn/${book.isbn}-M.jpg?default=false"
                                                         alt="${book.title}"
                                                         style="width: 100%; height: 100%; object-fit: cover;"
                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                    <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                        <i class="ri-book-3-line"></i>
                                                    </div>
                                                </div>

                                                <!-- Info Section -->
                                                <div style="padding: 20px; flex: 1; display: flex; flex-direction: column; min-width: 0;">
                                                    <div style="font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="${book.title}">
                                                        <c:out value="${book.title}" />
                                                    </div>
                                                    <div style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 8px;">
                                                        by <c:out value="${book.author}" />
                                                    </div>

                                                    <div style="margin-top: auto; width: 100%;">
                                                        <c:choose>
                                                            <c:when test="${activeBookIds.contains(book.id)}">
                                                                <button class="btn btn-secondary" disabled
                                                                    style="width: 100%; opacity: 0.5; padding: 8px; font-size: 0.85rem; justify-content: center;">
                                                                    <i class="ri-time-line"></i> Active Loan
                                                                </button>
                                                            </c:when>
                                                            <c:when test="${book.availableCopies > 0}">
                                                                <form action="${pageContext.request.contextPath}/borrowBook"
                                                                    method="POST" style="margin:0;">
                                                                    <input type="hidden" name="bookId" value="${book.id}">
                                                                    <input type="hidden" name="action" value="borrow">
                                                                    <button type="submit" class="btn btn-primary"
                                                                        style="width: 100%; padding: 8px; font-size: 0.9rem; justify-content: center;">
                                                                        Borrow
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-secondary" disabled
                                                                    style="width: 100%; opacity: 0.5; padding: 8px; font-size: 0.85rem; justify-content: center;">
                                                                    Out of Stock
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="glass-panel"
                                            style="padding: 40px; text-align: center; grid-column: 1/-1;">
                                            <i class="ri-ghost-line"
                                                style="font-size: 3rem; color: var(--text-muted);"></i>
                                            <p style="margin-top: 16px;">This section of the library is empty.</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </main>
                    </div>
                </body>

                </html>