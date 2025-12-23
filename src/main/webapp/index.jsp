<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>The Knowledge Nexus - Infinite Learning</title>
        <!-- Remix Icons -->
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
        <!-- Main Style -->
        <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">
        <!-- Google Fonts (Ensure they are loaded) -->
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap"
            rel="stylesheet">
    </head>

    <body style="overflow-x: hidden; position: relative;">

        <!-- Ambient Background Effects -->
        <div class="hero-bg-orb orb-1"></div>
        <div class="hero-bg-orb orb-2"></div>

        <!-- Navigation (Simple) -->
        <nav
            style="position: absolute; top: 0; left: 0; width: 100%; padding: 40px; display: flex; justify-content: space-between; align-items: center; z-index: 10;">
            <div
                style="font-size: 1.5rem; font-weight: 700; display: flex; align-items: center; gap: 10px; color: white;">
                <i class="ri-shining-2-fill" style="color: var(--primary);"></i> Nexus
            </div>
            <div>
                <a href="jsp/login.jsp"
                    style="color: white; text-decoration: none; font-weight: 500; margin-right: 30px; opacity: 0.8; transition: 0.3s;">Sign
                    In</a>
                <a href="jsp/signup.jsp" class="btn btn-primary" style="padding: 10px 24px; font-size: 0.9rem;">Get
                    Started</a>
            </div>
        </nav>

        <!-- Hero Section -->
        <section class="landing-hero">
            <div class="hero-badge">
                <i class="ri-sparkling-fill"></i> Experience the Future of Libraries
            </div>
            <h1 class="hero-title">
                Unlock the Universe <br /> of Knowledge.
            </h1>
            <p class="hero-subtitle">
                Dive into an infinite ocean of books, research, and wisdom.
                The Knowledge Nexus isn't just a library—it's your gateway to enlightenment.
            </p>
            <div class="hero-actions">
                <a href="jsp/signup.jsp" class="btn btn-primary" style="padding: 16px 40px; font-size: 1.1rem;">
                    Join the Nexus
                </a>
                <a href="jsp/login.jsp" class="btn btn-secondary"
                    style="padding: 16px 32px; font-size: 1.1rem; backdrop-filter: blur(10px);">
                    Member Login
                </a>
            </div>
        </section>

        <!-- Value Proposition (Features) -->
        <section class="features-section">
            <!-- Card 1 -->
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="ri-book-3-line"></i>
                </div>
                <h3 class="feature-title">Vast Collection</h3>
                <p class="feature-text">
                    Access thousands of premium titles across every genre.
                    From ancient history to quantum physics, it's all here.
                </p>
            </div>

            <!-- Card 2 -->
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="ri-flashlight-line"></i>
                </div>
                <h3 class="feature-title">Instant Access</h3>
                <p class="feature-text">
                    No waiting. Digital borrowing is seamless and instantaneous.
                    Read anywhere, anytime, on any device.
                </p>
            </div>

            <!-- Card 3 -->
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="ri-pie-chart-2-line"></i>
                </div>
                <h3 class="feature-title">Smart Tracking</h3>
                <p class="feature-text">
                    Monitor your reading habits, track loan history, and
                    get personalized recommendations based on your interests.
                </p>
            </div>
        </section>

        <!-- Footer -->
        <footer
            style="text-align: center; padding: 40px; color: var(--muted-text); font-size: 0.9rem; position: relative; z-index: 1;">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> The Knowledge Nexus. All Universes Reserved.</p>
        </footer>

    </body>

    </html>