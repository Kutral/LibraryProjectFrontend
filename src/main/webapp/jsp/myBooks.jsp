<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Books - The Knowledge Nexus</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
    <div class="dashboard-layout">
        <!-- User Sidebar -->
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
                    <a href="#" class="active"><i class="ri-book-3-line"></i> My Books</a>
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

        <!-- Main Content -->
        <main class="main-content">
            <header class="header-bar">
                <div>
                    <h1 style="font-size: 2.5rem; letter-spacing: -1px;">My Shelf</h1>
                    <p style="color: var(--text-secondary);">Manage your currently active loans.</p>
                </div>
                <div class="user-profile">
                    <div style="text-align: right;">
                        <div style="font-weight: 600;">${sessionScope.user.username}</div>
                        <div style="font-size: 0.8rem; color: var(--text-muted);">Member</div>
                    </div>
                    <div class="avatar-circle">
                        ${sessionScope.user.username.charAt(0)}
                    </div>
                </div>
            </header>

            <c:if test="${not empty param.msg}">
                <div class="alert alert-success" style="margin-bottom: 40px;">
                    <i class="ri-checkbox-circle-line"></i>
                    <c:out value="${param.msg}" />
                </div>
            </c:if>

            <div style="margin-bottom: 32px; display: flex; align-items: center; gap: 12px;">
                <h2 style="font-size: 1.25rem; font-weight: 600;">Currently Reading</h2>
                <span style="background: rgba(112, 0, 255, 0.2); color: #7000FF; padding: 2px 10px; border-radius: 99px; font-size: 0.8rem; font-weight: 700;">${activeLoans.size()}</span>
            </div>

            <div class="content-grid" style="grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));">
                <c:choose>
                    <c:when test="${not empty activeLoans}">
                        <c:forEach var="b" items="${activeLoans}">
                            <div class="glass-panel" style="padding: 0; display: flex; height: 200px; transition: transform 0.3s ease; border: 1px solid var(--glass-border); overflow: hidden; position: relative;">
                                <!-- Cover Section -->
                                <div style="width: 130px; background: rgba(0,0,0,0.3); border-right: 1px solid var(--glass-border);">
                                    <c:choose>
                                        <c:when test="${b.book != null}">
                                            <img src="https://covers.openlibrary.org/b/isbn/${b.book.isbn}-M.jpg?default=false" 
                                                 alt="${b.book.title}" 
                                                 style="width: 100%; height: 100%; object-fit: cover;"
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="book-fallback-icon" style="display: flex; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem;">
                                                <i class="ri-book-3-line"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem;">
                                        <i class="ri-book-3-line"></i>
                                    </div>
                                </div>

                                <!-- Info Section -->
                                <div style="padding: 20px; flex: 1; display: flex; flex-direction: column; min-width: 0;">
                                    <div style="font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        <c:out value="${b.bookTitle != null ? b.bookTitle : b.book.title}" />
                                    </div>
                                    <div style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 12px;">
                                        by <c:out value="${b.bookAuthor != null ? b.bookAuthor : b.book.author}" />
                                    </div>

                                    <div style="font-size: 0.8rem; color: var(--text-muted); display: grid; gap: 6px; margin-top: auto;">
                                        <div style="display: flex; align-items: center; gap: 8px;">
                                            <i class="ri-calendar-check-line" style="color: #34D399;"></i>
                                            <span>Borrowed: ${b.borrowDate}</span>
                                        </div>
                                    </div>

                                    <form action="${pageContext.request.contextPath}/borrowBook" method="post" style="margin-top: 16px;">
                                        <input type="hidden" name="action" value="return">
                                        <input type="hidden" name="borrowId" value="${b.id}">
                                        <input type="hidden" name="source" value="myBooks">
                                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 8px; font-size: 0.85rem; border-radius: 8px; justify-content: center;">
                                            <i class="ri-arrow-go-back-line"></i> Return Book
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="glass-panel" style="padding: 60px; text-align: center; grid-column: 1/-1;">
                            <div style="width: 80px; height: 80px; background: rgba(255,255,255,0.05); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 24px;">
                                <i class="ri-book-open-line" style="font-size: 2.5rem; color: var(--text-muted);"></i>
                            </div>
                            <h2 style="margin-bottom: 12px;">Your shelf is empty</h2>
                            <p style="color: var(--text-secondary); max-width: 400px; margin: 0 auto 32px;">Discover thousands of stories and knowledge in our catalog.</p>
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Browse Catalog</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>
</body>
</html>
