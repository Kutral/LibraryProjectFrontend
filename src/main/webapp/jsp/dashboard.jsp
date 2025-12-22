<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<% 
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - The Knowledge Nexus</title>
    <!-- Use timestamp to bust cache -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <span>📚</span> 
            <span>Knowledge Nexus</span>
        </a>
        <div class="navbar-user">
            <span>Welcome, <strong>${sessionScope.user.username}</strong></span>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="dashboard-container">
        
        <!-- Left Column: Books -->
        <main>
            
            <c:if test="${not empty param.msg}">
                <div class="alert alert-success">
                    <c:out value="${param.msg}"/>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">
                    <c:out value="${param.error}"/>
                </div>
            </c:if>

            <div class="section-title" style="border-bottom:none; margin-bottom: 0.5rem;">
                <span>Library Catalog</span>
            </div>

            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/dashboard" method="GET">
                    <input type="text" name="query" class="search-input" placeholder="Search by title, author..." value="${searchQuery}">
                </form>
            </div>

            <div class="book-grid">
                <c:choose>
                    <c:when test="${not empty books}">
                        <c:forEach var="book" items="${books}">
                            <div class="book-card">
                                <div class="book-icon">📖</div>
                                <div>
                                    <div class="book-title"><c:out value="${book.title}"/></div>
                                    <div class="book-author">by <c:out value="${book.author}"/></div>
                                </div>
                                <div class="book-meta">
                                    <c:choose>
                                        <c:when test="${activeBookIds.contains(book.id)}">
                                            <span class="badge" style="background:rgba(255, 255, 255, 0.1); color:var(--text-main); border:1px solid var(--text-muted);">Already Borrowed</span>
                                            <button class="btn" disabled style="width:100%; margin-top:10px; opacity:0.5; cursor:default;">Active Loan</button>
                                        </c:when>
                                        <c:when test="${book.availableCopies > 0}">
                                            <span class="badge badge-available"><c:out value="${book.availableCopies}"/> Available</span>
                                            <form action="${pageContext.request.contextPath}/borrowBook" method="POST" style="width:100%; margin-top:10px;">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <input type="hidden" name="action" value="borrow">
                                                <button type="submit" class="btn btn-primary" style="width:100%">Borrow</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-out">Out of Stock</span>
                                            <button class="btn btn-primary" disabled style="width:100%; margin-top:10px; opacity:0.5;">Unavailable</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>No books found matching your search.</p>
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn">Clear Search</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <!-- Right Column: History -->
        <aside class="history-panel">
            <div class="section-title">
                <span>My Bookshelf</span>
                <a href="${pageContext.request.contextPath}/dashboard" title="Refresh" style="color:var(--text-muted); font-size:1.2rem;">&#x21bb;</a>
            </div>
            
            <ul class="history-list">
                <c:choose>
                    <c:when test="${not empty history}">
                         <c:forEach var="item" items="${history}">
                            <li class="history-item">
                                <div class="history-info">
                                    <h4 style="margin:0; font-size:1rem; color:var(--text-main);"><c:out value="${item.bookTitle}"/></h4>
                                    <div class="history-date">
                                        Borrowed: <c:out value="${item.borrowDate}"/>
                                        <c:if test="${not empty item.returnDate}">
                                            <br>Returned: <c:out value="${item.returnDate}"/>
                                        </c:if>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${empty item.returnDate}">
                                        <form action="${pageContext.request.contextPath}/borrowBook" method="POST" style="margin:0;">
                                            <input type="hidden" name="borrowId" value="${item.id}">
                                            <input type="hidden" name="action" value="return">
                                            <button type="submit" class="btn btn-danger" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Return</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-available">Returned</span>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                         </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="empty-state" style="padding: 1rem; background:none;">You haven't borrowed any books.</li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </aside>

    </div>
</body>
</html>