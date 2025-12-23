package com.eswar.library.web;

import com.eswar.library.model.User;
import com.eswar.library.util.ApiClient;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = new ArrayList<>();
        try {
            ApiClient.ApiResponse apiResp = ApiClient.get("/admin/users");

            if (!apiResp.isSuccess()) apiResp = ApiClient.get("/users");
            
            if (apiResp.isSuccess()) {
                String json = apiResp.getDataJson();
                if (json != null) {
                    Gson gson = new Gson();
                    Type userListType = new TypeToken<ArrayList<User>>(){}.getType();
                    users = gson.fromJson(json, userListType);
                }
            } else {
                System.err.println("Failed to fetch users: " + apiResp.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("users", users);
        req.getRequestDispatcher("/jsp/admin_users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String error = null;

        try {
            Map<String, String> headers = new HashMap<>();
            headers.put("X-User-ID", String.valueOf(currentUser.getId()));

            if ("update".equals(action)) {
                Map<String, Object> payload = new HashMap<>();
                payload.put("id", Integer.parseInt(req.getParameter("id")));
                payload.put("email", req.getParameter("email"));
                payload.put("role", req.getParameter("role"));

                ApiClient.ApiResponse apiResp = ApiClient.put("/admin/users", payload, headers);
                if (!apiResp.isSuccess()) error = apiResp.getMessage();

            } else if ("delete".equals(action)) {
                String id = req.getParameter("id");
                System.out.println("AdminUsersServlet: Attempting to delete user ID: " + id);
                
                // Try query parameter first (as per documentation)
                ApiClient.ApiResponse apiResp = ApiClient.delete("/admin/users?id=" + id, headers);
                System.out.println("Delete (Query Param) Status: " + apiResp.getStatusCode());
                
                // Fallback: Try RESTful path parameter
                if (!apiResp.isSuccess()) {
                    ApiClient.ApiResponse pathResp = ApiClient.delete("/admin/users/" + id, headers);
                    System.out.println("Delete (Path Param) Status: " + pathResp.getStatusCode());
                    if (pathResp.isSuccess()) apiResp = pathResp;
                }
                
                if (!apiResp.isSuccess()) {
                    error = "User deletion failed (HTTP " + apiResp.getStatusCode() + "): " + apiResp.getMessage();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "System error: " + e.getMessage();
        }

        if (error != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/users?error=" + URLEncoder.encode(error, StandardCharsets.UTF_8));
        } else {
            String msg = "Operation completed successfully.";
            resp.sendRedirect(req.getContextPath() + "/admin/users?msg=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));
        }
    }
}