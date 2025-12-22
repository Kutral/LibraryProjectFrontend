<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        body {
            /* Ensure centering for login page specifically */
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 style="font-size: 2rem;">Welcome Back</h1>
        <p>Sign in to continue to The Knowledge Nexus</p>
        
        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
            <div class="alert alert-danger"><%= error %></div>
        <%
            }
        %>
        <%
            String param = request.getParameter("signupSuccess");
            if ("true".equals(param)) {
        %>
            <div class="alert alert-success">Registration successful! Please login.</div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required placeholder="Enter your username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Sign In</button>
        </form>
        
        <p class="footer-text">
            New here? <a href="signup.jsp" class="link-highlight">Create an account</a>
        </p>
    </div>

</body>
</html>