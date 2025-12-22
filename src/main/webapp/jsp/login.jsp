<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; min-height: 100vh;">

    <div class="container">
        <div style="margin-bottom: 2rem;">
            <span style="font-size: 3rem;">📚</span>
        </div>
        <h1>Welcome Back</h1>
        <p>Sign in to continue to Knowledge Nexus</p>
        
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
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.75rem;">Sign In</button>
        </form>
        
        <p class="footer-text">
            New here? <a href="signup.jsp" class="link-highlight">Create an account</a>
        </p>
    </div>

</body>
</html>
