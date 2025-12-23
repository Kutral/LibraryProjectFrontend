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
                <title>My Borrow History</title>
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                                <a href="${pageContext.request.contextPath}/index.jsp"><i
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

                        <div class="glass-panel">
                            <table class="premium-table">
                                <thead>
                                    <tr>
                                        <th>Book Details</th>
                                        <th>Borrowed</th>
                                        <th>Returning</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${empty history}">
                                            <tr>
                                                <td colspan="4"
                                                    style="text-align:center; padding: 40px; color:var(--text-muted);">
                                                    <i class="ri-history-line"
                                                        style="font-size: 2rem; display:block; margin-bottom:10px;"></i>
                                                    You haven't borrowed any books yet.
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="b" items="${history}">
                                                <tr>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${b.book != null}">
                                                                <div style="display: flex; align-items: center; gap: 16px;">
                                                                    <div style="width: 45px; height: 68px; border-radius: 6px; overflow: hidden; background: rgba(255,255,255,0.05); flex-shrink: 0;">
                                                                        <img src="https://covers.openlibrary.org/b/isbn/${b.book.isbn}-S.jpg?default=false" 
                                                                             alt="Cover" 
                                                                             style="width: 100%; height: 100%; object-fit: cover;"
                                                                             onerror="this.style.display='none'; this.parentNode.innerHTML='<div style=\'width:100%;height:100%;display:flex;align-items:center;justify-content:center;color:var(--text-muted);\'><i class=\'ri-book-line\'></i></div>';">
                                                                    </div>
                                                                    <div>
                                                                        <div style="font-weight: 600; color: var(--text-primary);">
                                                                            ${b.book.title}</div>
                                                                        <div style="font-size: 0.85rem; color: var(--text-secondary);">
                                                                            by ${b.book.author}</div>
                                                                    </div>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: var(--text-muted);">Book ID:
                                                                    ${b.bookId}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${b.borrowDate}</td>
                                                    <td>${b.returnDate != null ? b.returnDate : '-'}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${b.returned || b.returnDate != null}">
                                                                <span class="badge badge-success">Returned</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form
                                                                    action="${pageContext.request.contextPath}/borrowBook"
                                                                    method="post" style="display:inline;">
                                                                    <input type="hidden" name="action" value="return">
                                                                    <input type="hidden" name="borrowId"
                                                                        value="${b.id}">
                                                                    <input type="hidden" name="source" value="history">
                                                                    <button type="submit" class="btn btn-primary"
                                                                        style="padding: 6px 16px; font-size: 0.75rem; min-width: auto;">
                                                                        Return
                                                                    </button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                    </main>
                </div>

            </body>

            </html>