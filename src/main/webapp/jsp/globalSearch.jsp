<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Global Search - The Knowledge Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="dashboard-layout">
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <aside class="sidebar">
                    <div class="sidebar-brand">
                        <i class="ri-shield-star-fill"></i> Admin
                    </div>
                    <ul class="nav-links">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="ri-home-4-line"></i> Overview</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="active"><i class="ri-earth-line"></i> Global Search</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/requests"><i class="ri-git-pull-request-line"></i> Requests</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/users"><i class="ri-user-settings-line"></i> Users</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/books"><i class="ri-book-3-line"></i> Inventory</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/admin/borrows"><i class="ri-exchange-line"></i> Circulation</a>
                        </li>
                        <li class="nav-item" style="margin-top: auto;">
                            <a href="${pageContext.request.contextPath}/logout"><i class="ri-logout-box-r-line"></i> Logout</a>
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
                            <a href="${pageContext.request.contextPath}/dashboard"><i class="ri-dashboard-line"></i> Discover</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="active"><i class="ri-earth-line"></i> Global Search</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/myBooks"><i class="ri-book-3-line"></i> My Books</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/requests"><i class="ri-git-pull-request-line"></i> My Requests</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/history"><i class="ri-history-line"></i> History</a>
                        </li>
                        <li class="nav-item" style="margin-top: auto;">
                            <a href="${pageContext.request.contextPath}/logout"><i class="ri-logout-box-r-line"></i> Logout</a>
                        </li>
                    </ul>
                </aside>
            </c:otherwise>
        </c:choose>

        <main class="main-content">
            <header class="header-bar">
                <div>
                    <h1 style="font-size: 2rem;">Global Library</h1>
                    <p style="color: var(--text-secondary);">Search books across the world via Open Library.</p>
                </div>
                <div class="user-profile">
                    <div style="text-align: right;">
                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                        <div style="font-size: 0.8rem; color: var(--text-muted);">${sessionScope.user.role == 'ADMIN' ? 'Administrator' : 'Standard Member'}</div>
                    </div>
                    <div class="avatar-circle">
                        ${sessionScope.user.username.charAt(0)}
                    </div>
                </div>
            </header>

            <div class="form-group" style="max-width: 600px; margin-bottom: 40px;">
                <form action="${pageContext.request.contextPath}/globalSearch" method="GET" style="position:relative;">
                    <i class="ri-search-2-line" style="position:absolute; left:16px; top:18px; color:var(--text-secondary);"></i>
                    <input type="text" name="query" placeholder="Search by title, author, ISBN..." value="${searchQuery}" 
                           style="padding-left: 48px; background: rgba(255,255,255,0.05);">
                    <button type="submit" class="btn btn-primary" style="position:absolute; right:8px; top:8px; padding: 8px 16px;">Search</button>
                </form>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <div class="content-grid" style="grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));">
                <c:choose>
                    <c:when test="${not empty results}">
                        <c:forEach var="book" items="${results}">
                            <div class="glass-panel" style="padding: 0; display: flex; height: 200px; transition: transform 0.3s ease; border: 1px solid var(--glass-border); overflow: hidden; position: relative;">
                                <!-- Cover Section -->
                                <div style="width: 130px; background: rgba(0,0,0,0.3); border-right: 1px solid var(--glass-border); position: relative;">
                                    <c:set var="isbn" value="${book.getFirstIsbn()}" />
                                    <c:choose>
                                        <c:when test="${book.coverI > 0}">
                                            <img src="https://covers.openlibrary.org/b/id/${book.coverI}-M.jpg?default=false" 
                                                 alt="${book.title}" 
                                                 style="width: 100%; height: 100%; object-fit: cover;"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                            <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                <i class="ri-book-3-line"></i>
                                            </div>
                                        </c:when>
                                        <c:when test="${not empty isbn}">
                                            <img src="https://covers.openlibrary.org/b/isbn/${isbn}-M.jpg?default=false" 
                                                 alt="${book.title}" 
                                                 style="width: 100%; height: 100%; object-fit: cover;"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                            <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                <i class="ri-book-3-line"></i>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="book-fallback-icon" style="display: flex; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                <i class="ri-book-3-line"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Info Section -->
                                <div style="padding: 20px; flex: 1; display: flex; flex-direction: column; min-width: 0;">
                                    <div class="book-title" style="font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="${book.title}">
                                        ${book.title}
                                    </div>
                                    <div class="book-author" style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 8px;">
                                        ${book.getAuthorsJoined()}
                                    </div>
                                    <div style="font-size: 0.8rem; color: var(--text-muted); margin-bottom: 12px; font-family: monospace;">
                                        ${book.first_publish_year} • ${not empty isbn ? isbn : 'No ISBN'}
                                    </div>

                                    <div style="margin-top: auto;">
                                        <c:choose>
                                            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                                                <a href="${pageContext.request.contextPath}/jsp/addBook.jsp?title=${book.title}&author=${book.getAuthorsJoined()}&isbn=${isbn}" 
                                                   class="btn btn-secondary" style="width: 100%; padding: 8px; font-size: 0.9rem; justify-content: center;">
                                                    <i class="ri-add-line"></i> Import to Local
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/requests" method="post" style="margin: 0;">
                                                    <input type="hidden" name="action" value="create">
                                                    <input type="hidden" name="title" value="${book.title}">
                                                    <input type="hidden" name="author" value="${book.getAuthorsJoined()}">
                                                    <input type="hidden" name="isbn" value="${isbn}">
                                                    <button type="submit" class="btn btn-secondary" style="width: 100%; padding: 8px; font-size: 0.9rem; justify-content: center;">
                                                        <i class="ri-git-pull-request-line"></i> Request Book
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:when test="${not empty searchQuery}">
                        <div class="glass-panel" style="padding: 40px; text-align: center; grid-column: 1/-1;">
                            <i class="ri-search-line" style="font-size: 3rem; color: var(--text-muted);"></i>
                            <p style="margin-top: 16px;">No results found for "${searchQuery}" on Open Library.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="glass-panel" style="padding: 40px; text-align: center; grid-column: 1/-1; background: linear-gradient(rgba(255,255,255,0.02), rgba(255,255,255,0.05));">
                            <i class="ri-earth-line" style="font-size: 4rem; color: #7000FF; margin-bottom: 20px; display: block;"></i>
                            <h2>Explore the Global Library</h2>
                            <p style="color: var(--text-secondary); max-width: 500px; margin: 10px auto;">Search millions of books from the Open Library repository and discover your next read.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>