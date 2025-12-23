<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - The Knowledge Nexus</title>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
        <link rel="stylesheet"
            href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
        <style>
            body {
                /* Ensure centering for login page specifically */
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>

    <body>

        <div class="center-wrapper">
            <div class="glass-panel auth-card">
                <div style="margin-bottom: 32px;">
                    <h1 style="margin-bottom: 8px;">Welcome Back</h1>
                    <p>Access your personal library.</p>
                </div>

                <% String error=(String) request.getAttribute("errorMessage"); if (error !=null) { %>
                    <div class="alert alert-danger">
                        <i class="ri-error-warning-line"></i>
                        <%= error %>
                    </div>
                    <% } %>
                        <% String param=request.getParameter("signupSuccess"); if ("true".equals(param)) { %>
                            <div class="alert alert-success">
                                <i class="ri-checkbox-circle-line"></i> Registration successful!
                            </div>
                            <% } %>

                                <form action="${pageContext.request.contextPath}/login" method="post">
                                    <div class="form-group" style="text-align: left;">
                                        <label for="username"><i class="ri-user-line"></i> Username</label>
                                        <input type="text" id="username" name="username" required
                                            placeholder="Enter username">
                                    </div>
                                    <div class="form-group" style="text-align: left;">
                                        <label for="password"><i class="ri-lock-line"></i> Password</label>
                                        <input type="password" id="password" name="password" required
                                            placeholder="Enter password">
                                    </div>
                                    <button type="submit" class="btn btn-primary"
                                        style="width: 100%; justify-content: center;">
                                        Sign In
                                    </button>
                                </form>

                                <div style="margin-top: 32px; font-size: 0.9rem; color: var(--text-muted);">
                                    New user? <a href="signup.jsp" style="color: #fff; font-weight: 600;">Create
                                        Account</a>
                                </div>
            </div>
        </div>

    </body>

    </html>