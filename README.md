# 📚 Library Management System - Frontend

A modern, glassmorphism-style web interface for managing a library, built with Java (JSP/Servlets).

## 🚀 Live Demo & Links
- **Frontend App:** https://libraryfrontend-1ter.onrender.com
- **Backend API:** https://librarybackend-1dvi.onrender.com

## ✨ New Features
- **Modern UI:** Complete overhaul using a Dark Glassmorphism theme.
- **Global Search:** Search millions of books via Open Library API integration.
- **Automated Covers:** Real-time book cover fetching based on ISBN.
- **My Shelf:** Dedicated section for users to manage active loans and returns.
- **Book Requests:** Collaborative system for users to request new titles.
- **Admin Stats:** Live dashboard showing total users, books, and active loans.
- **API Monitor:** Real-time status tracker for external API connectivity.

## 🛡️ Security & Fixes
- **Auth Filter:** Secured all private routes against unauthorized access.
- **Logout Logic:** Fixed "Back Button" vulnerability by implementing server-side session invalidation and anti-caching headers.
- **Robust Deletion:** Implemented a triple-fallback system for deleting books/users to ensure backend compatibility.

## 🛠️ Tech Stack
- **Core:** Java 21, Jakarta Servlet 6.0, JSP 3.0
- **Integrations:** Open Library (Search & Covers)
- **Data:** Google Gson for REST API communication
- **Deployment:** Docker (Multi-stage build) for Render hosting

## 💻 Local Setup
1. Ensure the `BASE_URL` in `ApiClient.java` points to the live backend URL.
2. Build the project:
   ```bash
   ./mvnw clean package
   ```
3. Run the generated WAR on Tomcat 10+.