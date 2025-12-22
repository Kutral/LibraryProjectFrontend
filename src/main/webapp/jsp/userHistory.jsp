<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    // Simple redirect if accessed directly without data
    if (request.getAttribute("history") == null) {
        response.sendRedirect(request.getContextPath() + "/history");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Borrow History</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <h1>My Borrow History</h1>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-msg">${errorMessage}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty history}">
                <p>You haven't borrowed any books yet.</p>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>Book</th>
                            <th>Borrowed On</th>
                            <th>Returned On</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${history}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${b.book != null}">
                                            ${b.book.title} <small>(${b.book.author})</small>
                                        </c:when>
                                        <c:otherwise>
                                            Book ID: ${b.bookId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${b.borrowDate}</td>
                                <td>${b.returnDate != null ? b.returnDate : '-'}</td>
                                <td>
                                    <span class="status ${b.returned ? 'status-returned' : 'status-active'}">
                                        ${b.returned ? 'Returned' : 'Active'}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <div class="mt-20">
            <a href="${pageContext.request.contextPath}/jsp/dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
