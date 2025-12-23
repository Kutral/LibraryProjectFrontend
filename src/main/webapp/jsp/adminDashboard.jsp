<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% if (session.getAttribute("user") == null || !"ADMIN".equalsIgnoreCase(((com.eswar.library.model.User)session.getAttribute("user")).getRole())) { 
    response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"); return; } %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - The Knowledge Nexus</title>
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
        <link rel="stylesheet"
            href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    </head>

    <body>

        <div class="dashboard-layout">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="sidebar-brand">
                    <i class="ri-shield-star-fill"></i> Admin
                </div>
                <ul class="nav-links">
                    <li class="nav-item">
                        <a href="#" class="active"><i class="ri-home-4-line"></i> Overview</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/globalSearch"><i class="ri-earth-line"></i>
                            Global Search</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/requests"><i class="ri-git-pull-request-line"></i>
                            Requests</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/users"><i class="ri-user-settings-line"></i>
                            Users</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/books"><i class="ri-book-3-line"></i>
                            Inventory</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/borrows"><i class="ri-exchange-line"></i>
                            Circulation</a>
                    </li>
                    <li class="nav-item" style="margin-top: auto;">
                        <a href="${pageContext.request.contextPath}/index.jsp"><i class="ri-logout-box-r-line"></i>
                            Logout</a>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <main class="main-content">

                <header class="header-bar">
                    <div>
                        <h1 style="font-size: 2rem;">Command Center</h1>
                        <p style="color: var(--text-secondary);">System status and management.</p>
                    </div>
                    <div class="user-profile">
                        <div style="text-align: right;">
                            <div style="font-weight: 600;">${sessionScope.user.username}</div>
                            <div style="font-size: 0.8rem; color: var(--text-muted);">Administrator</div>
                        </div>
                        <div class="avatar-circle">
                            ${sessionScope.user.username.charAt(0)}
                        </div>
                    </div>
                </header>

                <!-- Stats Row -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 24px; margin-bottom: 40px;">
                    <div class="glass-panel" style="padding: 24px; display: flex; align-items: center; gap: 20px;">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: rgba(52, 211, 153, 0.2); color: #34D399; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="ri-user-line"></i>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase;">Total Users</div>
                            <div style="font-size: 1.5rem; font-weight: 700;">${stats.totalUsers != null ? stats.totalUsers : '0'}</div>
                        </div>
                    </div>
                    <div class="glass-panel" style="padding: 24px; display: flex; align-items: center; gap: 20px;">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: rgba(112, 0, 255, 0.2); color: #7000FF; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="ri-book-3-line"></i>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase;">Total Books</div>
                            <div style="font-size: 1.5rem; font-weight: 700;">${stats.totalBooks != null ? stats.totalBooks : '0'}</div>
                        </div>
                    </div>
                    <div class="glass-panel" style="padding: 24px; display: flex; align-items: center; gap: 20px;">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: rgba(251, 191, 36, 0.2); color: #FBBF24; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="ri-exchange-line"></i>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase;">Active Loans</div>
                            <div style="font-size: 1.5rem; font-weight: 700;">${stats.activeBorrows != null ? stats.activeBorrows : '0'}</div>
                        </div>
                    </div>
                    <div class="glass-panel" style="padding: 24px; display: flex; align-items: center; gap: 20px;">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: ${publicApiWorking ? 'rgba(52, 211, 153, 0.2)' : 'rgba(248, 113, 113, 0.2)'}; color: ${publicApiWorking ? '#34D399' : '#F87171'}; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                            <i class="ri-global-line"></i>
                        </div>
                        <div>
                            <div style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase;">Public API</div>
                            <div style="font-size: 1.25rem; font-weight: 700;">${publicApiWorking ? 'Online' : 'Offline'}</div>
                        </div>
                    </div>
                </div>

                <!-- Management Sections -->
                <div style="margin-top: 32px; margin-bottom: 24px;">
                    <h2 style="font-size: 1.5rem; font-weight: 700;">Quick Actions</h2>
                </div>

                <div class="content-grid" style="padding-bottom: 40px;">

                    <a href="${pageContext.request.contextPath}/admin/users" class="card"
                        style="text-decoration: none; padding: 24px; display: flex; flex-direction: column; align-items: flex-start; height: 100%;">
                        <!-- Icon: Pink (#FF2D95) -->
                        <div class="icon-bg">
                            <i class="ri-user-star-line" style="color: #FF2D95; font-size: 32px;"></i>
                        </div>
                        <!-- Title: White -->
                        <div style="font-size: 1.25rem; font-weight: 700; color: #ffffff; margin-bottom: 8px;">Users
                        </div>
                        <!-- Desc: Gray -->
                        <div style="color: rgba(255, 255, 255, 0.6); margin-bottom: 24px; font-weight: 500;">Manage
                            access & roles</div>
                        <div class="btn-text">Access Users &rarr;</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/books" class="card"
                        style="text-decoration: none; padding: 24px; display: flex; flex-direction: column; align-items: flex-start; height: 100%;">
                        <div class="icon-bg">
                            <i class="ri-book-3-line" style="color: #FF2D95; font-size: 32px;"></i>
                        </div>
                        <div style="font-size: 1.25rem; font-weight: 700; color: #ffffff; margin-bottom: 8px;">Inventory
                        </div>
                        <div style="color: rgba(255, 255, 255, 0.6); margin-bottom: 24px; font-weight: 500;">Add &
                            remove books</div>
                        <div class="btn-text">Manage Books &rarr;</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/borrows" class="card"
                        style="text-decoration: none; padding: 24px; display: flex; flex-direction: column; align-items: flex-start; height: 100%;">
                        <div class="icon-bg">
                            <i class="ri-exchange-line" style="color: #FF2D95; font-size: 32px;"></i>
                        </div>
                        <div style="font-size: 1.25rem; font-weight: 700; color: #ffffff; margin-bottom: 8px;">
                            Circulation</div>
                        <div style="color: rgba(255, 255, 255, 0.6); margin-bottom: 24px; font-weight: 500;">Track
                            active loans</div>
                        <div class="btn-text">View Loans &rarr;</div>
                    </a>

                </div>

            </main>
        </div>

    </body>

    </html>