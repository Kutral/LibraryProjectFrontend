# 📚 Library Management System

<div align="center">

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=java)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-black?style=for-the-badge&logo=jakarta)
![Three.js](https://img.shields.io/badge/Three.js-r128-black?style=for-the-badge&logo=three.js)
![Docker](https://img.shields.io/badge/Docker-Ready-blue?style=for-the-badge&logo=docker)

### *A professional, full-stack library management solution with a modern glassmorphism interface.*

</div>

---

## 🚀 Live Demo & Links
*   **Frontend App:** [https://libraryfrontend-1ter.onrender.com](https://libraryfrontend-1ter.onrender.com)
*   **Backend API:** [https://librarybackend-1dvi.onrender.com](https://librarybackend-1dvi.onrender.com)
*   **Backend Repository:** [https://github.com/Kutral/LibraryProject](https://github.com/Kutral/LibraryProject)

---

## ✨ New Features
*   **Modern Glassmorphism UI:** A sleek, dark-themed interface with translucent elements and blurred backgrounds.
*   **Immersive 3D Experience:** Dynamic 3D starfield background powered by **Three.js** on authentication pages.
*   **Global Book Search:** Integrated with the **Open Library API** to search and import millions of books.
*   **Dynamic Cover Art:** Automatic fetching and display of book covers using ISBN-based URL resolution.
*   **Responsive Dashboard:** Synchronized grid layouts for books, borrowing history, and global search results.

---

## 🚀 Key Features

### 👤 For Users
*   🔐 **Secure Authentication:** Robust Login and Signup with session management and secure routing.
*   🔍 **Smart Discovery:** Real-time search across the local catalog and global library databases.
*   📖 **Borrowing Engine:** Transaction-safe system for borrowing books with real-time availability updates.
*   ↩️ **Easy Returns:** Simplified one-click return process to manage your active loans.
*   📜 **History Tracking:** Comprehensive view of all your past and currently active borrows.

### 🛡️ For Administrators
*   📚 **Inventory Control:** Complete CRUD operations (Create, Read, Update, Delete) for managing the local collection.
*   👥 **User Management:** Oversight of all registered users with the ability to manage roles and accounts.
*   📝 **Request Approval:** Dedicated system to review and process user requests for acquiring new books.
*   📊 **Analytics Dashboard:** Visual insights into total library statistics, including user activity and circulation trends.

---

## 🛠️ Tech Stack

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Language** | Java 21 | Modern LTS version utilized for backend logic and API interaction. |
| **Web Framework** | Jakarta Servlet 6.1 & JSP 3.0 | Core technologies for handling web requests and dynamic content rendering. |
| **Dependency Injection** | Weld (CDI 4.0) | JBoss Weld implementation for Contexts and Dependency Injection. |
| **REST Integration** | Jersey 4.0 (JAX-RS) | GlassFish Jersey for building and consuming RESTful web services. |
| **JSON Processing** | Google Gson 2.10 | High-performance library for converting Java Objects into JSON and back. |
| **Frontend Visuals** | Three.js & Remix Icons | 3D graphics library for the background and comprehensive iconography. |
| **Styling** | CSS3 (Custom Glassmorphism) | Modern CSS techniques for a translucent, blurred-background aesthetic. |
| **Templating** | JSTL 3.0 | Jakarta Standard Tag Library for simplified JSP development. |
| **Build Tool** | Maven 3.9 | For dependency management, lifecycle control, and automated builds. |

---

## 💻 Local Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/kutraleeswaran/LibraryProjectFrontend.git
   cd LibraryProjectFrontend
   ```

2. **Configure API Frequency:**
   Update the `BASE_URL` in `src/main/java/com/eswar/library/util/ApiClient.java` to point to your backend coordinates.

3. **Compile the Project:**
   ```bash
   ./mvnw clean package
   ```

4. **Run:**
   Deploy the generated `library.war` from the `target` folder to an Apache Tomcat 10.1+ server.

---

<div align="center">

### Made with ❤️ by Kutraleeswaran

[![GitHub](https://img.shields.io/badge/GitHub-Profile-black?style=for-the-badge&logo=github)](https://github.com/kutraleeswaran)


*"Knowledge is the only infinite resource."*

</div>
