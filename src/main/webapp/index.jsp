<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - The Knowledge Nexus</title>
    <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        body {
            /* Center the landing page card specifically */
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>The Knowledge Nexus</h1>
    <p>Your gateway to a universe of wisdom. Explore, learn, and expand your horizons with our curated collection.</p>

    <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
        <a href="jsp/login.jsp" class="btn">Log In</a>
        <a href="jsp/signup.jsp" class="btn btn-secondary">Sign Up</a>
    </div>
</div>
</body>
</html>
