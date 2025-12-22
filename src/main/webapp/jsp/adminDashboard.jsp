<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - The Knowledge Nexus</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        .admin-header {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.9), rgba(15, 23, 42, 0.95));
            border-bottom: 1px solid var(--glass-border);
            padding: 3rem 2rem;
            border-radius: 24px;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
        }
        
        .admin-header::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 100%;
            background: radial-gradient(circle at center, rgba(79, 172, 254, 0.1) 0%, transparent 70%);
            pointer-events: none;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: rgba(30, 41, 59, 0.4);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.3s;
        }
        
        .stat-card:hover {
            transform: translateY(-3px);
            background: rgba(30, 41, 59, 0.6);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .stat-info h3 {
            font-size: 0.9rem;
            margin: 0;
            color: var(--text-muted);
            font-weight: 500;
        }
        
        .stat-info p {
            font-size: 1.25rem;
            margin: 0;
            color: var(--text-main);
            font-weight: 700;
        }

        .section-header {
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .section-header h2 {
            font-size: 1.5rem;
            margin: 0;
        }
        
        .section-line {
            height: 1px;
            background: var(--glass-border);
            flex-grow: 1;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="#" class="navbar-brand">
            <span>🛡️</span> 
            <span>Admin Portal</span>
        </a>
        <div class="navbar-user">
            <span>Administrator</span>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container" style="max-width: 1100px; margin-top: 2rem; background: transparent; box-shadow: none; border: none; padding: 0;">
        
        <!-- Welcome Hero -->
        <div class="admin-header">
            <h1>Welcome back, Admin</h1>
            <p style="margin-bottom: 0; max-width: 600px;">Here's what's happening in the library today. Manage your resources efficiently.</p>
        </div>

        <!-- Quick Status (Visual only for now) -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon" style="background: rgba(34, 197, 94, 0.2); color: var(--success-color);">⚡</div>
                <div class="stat-info">
                    <h3>System Status</h3>
                    <p>Operational</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: rgba(79, 172, 254, 0.2); color: var(--primary-color);">🕒</div>
                <div class="stat-info">
                    <h3>Server Time</h3>
                    <p><%= new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date()) %></p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon" style="background: rgba(245, 158, 11, 0.2); color: var(--warning-color);">🔒</div>
                <div class="stat-info">
                    <h3>Security</h3>
                    <p>Protected</p>
                </div>
            </div>
        </div>

        <div class="section-header">
            <h2>Management Console</h2>
            <div class="section-line"></div>
        </div>
        
        <!-- Action Cards -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
            
            <!-- Users -->
            <div class="book-card" style="text-align: center; border-color: var(--glass-border); padding: 2rem;">
                <div class="book-icon" style="background: rgba(79, 172, 254, 0.1); width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: var(--secondary-color);">👥</div>
                <div class="book-title" style="font-size: 1.5rem; margin-bottom: 1rem;">User Management</div>
                <p>View registered users, manage roles, and handle account access control.</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary" style="width: 100%; margin-top: auto;">Manage Users</a>
            </div>
            
            <!-- Books -->
            <div class="book-card" style="text-align: center; border-color: var(--glass-border); padding: 2rem;">
                <div class="book-icon" style="background: rgba(245, 158, 11, 0.1); width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: var(--warning-color);">📚</div>
                <div class="book-title" style="font-size: 1.5rem; margin-bottom: 1rem;">Book Inventory</div>
                <p>Track book stock, add new arrivals, and organize the library catalog.</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary" style="width: 100%; margin-top: auto;">Manage Books</a>
            </div>

            <!-- Borrows -->
            <div class="book-card" style="text-align: center; border-color: var(--glass-border); padding: 2rem;">
                <div class="book-icon" style="background: rgba(34, 197, 94, 0.1); width: 80px; height: 80px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: var(--success-color);">📅</div>
                <div class="book-title" style="font-size: 1.5rem; margin-bottom: 1rem;">Borrow History</div>
                <p>Monitor active loans, check due dates, and view user borrowing history.</p>
                <a href="${pageContext.request.contextPath}/admin/borrows" class="btn btn-primary" style="width: 100%; margin-top: auto;">View History</a>
            </div>

        </div>

        <div style="margin-top: 4rem; text-align: center; color: var(--text-muted); font-size: 0.9rem;">
            &copy; <%= new java.util.Date().getYear() + 1900 %> The Knowledge Nexus Admin Portal. All systems nominal.
        </div>

    </div>

</body>
</html>