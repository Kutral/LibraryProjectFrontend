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
    <title>Library Dashboard</title>
    <!-- Use standard link with context path -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/dashboard" class="navbar-brand">
            <span style="font-size: 1.5rem;">📚</span> 
            <span>Knowledge Nexus</span>
        </a>
        <div class="navbar-user">
            <span>Hello, ${sessionScope.user.username}</span>
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

            <div class="section-title" style="margin-bottom: 0.5rem; border:none;">
                <span>Library Catalog</span>
            </div>

            <div class="search-bar">
                <form action="${pageContext.request.contextPath}/dashboard" method="GET">
                    <input type="text" name="query" class="search-input" placeholder="Search books by title or author..." value="${searchQuery}">
                </form>
            </div>

            <div class="book-grid">
                <c:choose>
                    <c:when test="${not empty books}">
                        <c:forEach var="book" items="${books}">
                            <div class="book-card">
                                <div class="book-icon">📘</div>
                                <div>
                                    <div class="book-title"><c:out value="${book.title}"/></div>
                                    <div class="book-author"><c:out value="${book.author}"/></div>
                                </div>
                                <div class="book-meta">
                                    <c:choose>
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
                                            <button class="btn btn-primary" disabled style="width:100%; margin-top:10px;">Unavailable</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <p>No books found matching your search.</p>
                            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">Clear Search</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <!-- Right Column: History -->
        <aside class="history-panel">
            <div class="section-title">
                <span>My Bookshelf</span>
                <a href="${pageContext.request.contextPath}/dashboard" title="Refresh" style="color:var(--text-secondary); text-decoration:none;">&#x21bb;</a>
            </div>
            
            <ul class="history-list">
                <c:choose>
                    <c:when test="${not empty history}">
                         <c:forEach var="item" items="${history}">
                            <li class="history-item">
                                <div class="history-info">
                                    <h4><c:out value="${item.bookTitle}"/></h4>
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
                                            <button type="submit" class="btn btn-danger" style="padding: 0.25rem 0.75rem; font-size: 0.8rem;">Return</button>
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
                        <li class="empty-state">Your history is empty.</li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </aside>

    </div>
</body>
</html>
