<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome - The Knowledge Nexus</title>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
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
        <div class="center-wrapper">
            <div class="glass-panel auth-card">
                <div class="auth-logo">
                    <i class="ri-infinity-line" style="display:block; font-size: 4rem; margin-bottom: 10px;"></i>
                    Nexus
                </div>
                <h1 style="font-size: 1.5rem; color: var(--text-primary); margin-bottom: 12px;">The Knowledge Nexus</h1>
                <p style="color: var(--text-secondary); line-height: 1.6;">Where wisdom meets infinity. Your premium
                    gateway to curated content.</p>

                <div style="display: flex; gap: 16px; justify-content: center; margin-top: 40px;">
                    <a href="jsp/login.jsp" class="btn btn-primary">
                        Log In <i class="ri-arrow-right-line"></i>
                    </a>
                    <a href="jsp/signup.jsp" class="btn btn-secondary">
                        Sign Up
                    </a>
                </div>
            </div>
        </div>
    </body>

    </html>