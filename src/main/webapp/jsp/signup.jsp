<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        body {
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1 style="font-size: 2rem;">Join the Nexus</h1>
        <p>Create your account and start exploring.</p>
        
        <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
        %>
            <div class="alert alert-danger"><%= error %></div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/signup" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required placeholder="Choose a username">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Create a password">
            </div>
            <button type="submit" class="btn btn-secondary" style="width: 100%;">Create Account</button>
        </form>
        
        <p class="footer-text">
            Already have an account? <a href="login.jsp" class="link-highlight">Log in</a>
        </p>
    </div>

</body>
</html>
