<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <% 
           // Simple redirect if accessed directly without data 
           if (request.getAttribute("history")==null) {
               response.sendRedirect(request.getContextPath() + "/history" ); 
               return; 
           } 
        %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>My Borrow History - The Knowledge Nexus</title>
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
                                <a href="${pageContext.request.contextPath}/dashboard"><i class="ri-dashboard-line"></i>
                                    Discover</a>
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
                                <a href="#" class="active"><i class="ri-history-line"></i> History</a>
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
                                <h1 style="font-size: 2rem;">My History</h1>
                                <p style="color: var(--text-secondary);">Your journey through the Nexus.</p>
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

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger"><i class="ri-error-warning-line"></i> ${errorMessage}</div>
                        </c:if>

                        <div class="content-grid" style="grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));">
                            <c:choose>
                                <c:when test="${empty history}">
                                    <div class="glass-panel" style="padding: 60px; text-align: center; grid-column: 1/-1;">
                                        <div style="width: 80px; height: 80px; background: rgba(255,255,255,0.05); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 24px;">
                                            <i class="ri-history-line" style="font-size: 2.5rem; color: var(--text-muted);"></i>
                                        </div>
                                        <h2 style="margin-bottom: 12px;">No activity yet</h2>
                                        <p style="color: var(--text-secondary); max-width: 400px; margin: 0 auto 32px;">Start your reading journey by borrowing your first book from the catalog.</p>
                                        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Browse Catalog</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="b" items="${history}">
                                        <div class="glass-panel" style="padding: 0; display: flex; height: 200px; transition: transform 0.3s ease; border: 1px solid var(--glass-border); overflow: hidden; position: relative; opacity: ${b.returned || b.returnDate != null ? '0.8' : '1'};">
                                            <!-- Cover Section -->
                                            <div style="width: 130px; background: rgba(0,0,0,0.3); border-right: 1px solid var(--glass-border); position: relative;">
                                                <c:choose>
                                                    <c:when test="${b.book != null}">
                                                        <img src="https://covers.openlibrary.org/b/isbn/${b.book.isbn}-M.jpg?default=false" 
                                                             alt="Cover" 
                                                             style="width: 100%; height: 100%; object-fit: cover;"
                                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                        <div class="book-fallback-icon" style="display: none; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem; position: absolute; top:0; left:0;">
                                                            <i class="ri-book-3-line"></i>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="book-fallback-icon" style="display: flex; width: 100%; height: 100%; align-items: center; justify-content: center; background: rgba(255, 153, 0, 0.1); color: #FF9900; font-size: 2.5rem;">
                                                            <i class="ri-book-3-line"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Info Section -->
                                            <div style="padding: 20px; flex: 1; display: flex; flex-direction: column; min-width: 0;">
                                                <div style="font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                    <c:out value="${b.bookTitle != null ? b.bookTitle : (b.book != null ? b.book.title : 'Unknown Book')}" />
                                                </div>
                                                <div style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 12px;">
                                                    by <c:out value="${b.bookAuthor != null ? b.bookAuthor : (b.book != null ? b.book.author : 'Unknown Author')}" />
                                                </div>

                                                <div style="font-size: 0.8rem; color: var(--text-muted); display: grid; gap: 6px; margin-top: auto;">
                                                    <div style="display: flex; align-items: center; gap: 8px;">
                                                        <i class="ri-calendar-line" style="color: var(--primary-accent);"></i>
                                                        <span>Borrowed: ${b.borrowDate}</span>
                                                    </div>
                                                    <c:if test="${b.returnDate != null}">
                                                        <div style="display: flex; align-items: center; gap: 8px;">
                                                            <i class="ri-checkbox-circle-line" style="color: var(--status-success);"></i>
                                                            <span>Returned: ${b.returnDate}</span>
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <div style="margin-top: 16px;">
                                                    <c:choose>
                                                        <c:when test="${b.returned || b.returnDate != null}">
                                                            <div class="badge badge-success" style="width: 100%; text-align: center; padding: 8px;">Returned</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form action="${pageContext.request.contextPath}/borrowBook" method="post" style="margin:0;">
                                                                <input type="hidden" name="action" value="return">
                                                                <input type="hidden" name="borrowId" value="${b.id}">
                                                                <input type="hidden" name="source" value="history">
                                                                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 8px; font-size: 0.85rem; justify-content: center;">
                                                                    <i class="ri-arrow-go-back-line"></i> Return Book
                                                                </button>
                                                            </form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </main>
                </div>

            </body>

            </html>