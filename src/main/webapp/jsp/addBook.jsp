<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <% if (session.getAttribute("user")==null ||
            !"ADMIN".equalsIgnoreCase(((com.eswar.library.model.User)session.getAttribute("user")).getRole())) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp" ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Add Book - The Knowledge Nexus</title>
                <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
                <link rel="stylesheet"
                    href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
                <style>
                    body {
                        justify-content: center;
                        align-items: center;
                    }
                </style>
            </head>

            <body>
                <div class="center-wrapper">
                    <div class="glass-panel auth-card" style="max-width: 500px;">
                        <div style="margin-bottom: 32px;">
                            <h1 style="margin-bottom: 8px;">Add New Book</h1>
                            <p>Expand the library collection.</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/books" method="post">
                            <input type="hidden" name="action" value="create">

                            <div class="form-group" style="text-align: left;">
                                <label for="title"><i class="ri-book-line"></i> Title</label>
                                <input type="text" id="title" name="title" required placeholder="Book Title" value="${param.title}">
                            </div>
                            <div class="form-group" style="text-align: left;">
                                <label for="author"><i class="ri-user-line"></i> Author</label>
                                <input type="text" id="author" name="author" required placeholder="Author Name" value="${param.author}">
                            </div>
                            <div class="form-group" style="text-align: left;">
                                <label for="isbn"><i class="ri-barcode-line"></i> ISBN</label>
                                <input type="text" id="isbn" name="isbn" required placeholder="ISBN Number" value="${param.isbn}">
                            </div>
                            <div class="form-group" style="text-align: left;">
                                <label for="copies"><i class="ri-hashtag"></i> Available Copies</label>
                                <input type="number" id="copies" name="copies" required min="1" value="1"
                                    placeholder="Quantity">
                            </div>

                            <div style="display: flex; gap: 1rem; margin-top: 32px;">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary"
                                    style="flex:1; justify-content: center;">Cancel</a>
                                <button type="submit" class="btn btn-primary"
                                    style="flex:1; justify-content: center;">Add Book</button>
                            </div>
                        </form>
                    </div>
                </div>
            </body>

            </html>