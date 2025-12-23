<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - The Knowledge Nexus</title>
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
            <div class="glass-panel auth-card">
                <div style="margin-bottom: 32px;">
                    <h1 style="margin-bottom: 8px;">Begin Journey</h1>
                    <p>Join the Nexus community.</p>
                </div>

                <% String error=(String) request.getAttribute("errorMessage"); if (error !=null) { %>
                    <div class="alert alert-danger">
                        <i class="ri-error-warning-line"></i>
                        <%= error %>
                    </div>
                    <% } %>

                        <form action="${pageContext.request.contextPath}/signup" method="post">
                            <div class="form-group" style="text-align: left;">
                                <label for="username"><i class="ri-user-smile-line"></i> Username</label>
                                <input type="text" id="username" name="username" required placeholder="Choose a handle">
                            </div>
                            <div class="form-group" style="text-align: left;">
                                <label for="email"><i class="ri-mail-line"></i> Email</label>
                                <input type="email" id="email" name="email" required placeholder="name@example.com">
                            </div>
                            <div class="form-group" style="text-align: left;">
                                <label for="password"><i class="ri-shield-key-line"></i> Password</label>
                                <input type="password" id="password" name="password" required
                                    placeholder="Secure passphrase">
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                                Create Account
                            </button>
                        </form>

                        <div style="margin-top: 32px; font-size: 0.9rem; color: var(--text-muted);">
                            Existing user? <a href="login.jsp" style="color: #fff; font-weight: 600;">Sign In</a>
                        </div>
            </div>
        </div>

    </body>

    </html>