package com.eswar.library.web;

import com.eswar.library.model.User;
import com.eswar.library.util.ApiClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/books")
public class AdminBooksServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String error = null;

        try {
            Map<String, String> headers = new HashMap<>();
            headers.put("X-User-ID", String.valueOf(user.getId()));

            if ("create".equals(action)) {
                System.out.println("AdminBooksServlet: Creating book...");
                Map<String, Object> payload = new HashMap<>();
                payload.put("title", req.getParameter("title"));
                payload.put("author", req.getParameter("author"));
                payload.put("isbn", req.getParameter("isbn"));
                payload.put("availableCopies", Integer.parseInt(req.getParameter("copies")));
                
                ApiClient.ApiResponse apiResp = ApiClient.post("/admin/books", payload, headers);
                if (!apiResp.isSuccess()) error = apiResp.getMessage();

            } else if ("update".equals(action)) {
                Map<String, Object> payload = new HashMap<>();
                int id = Integer.parseInt(req.getParameter("id"));
                payload.put("id", id);
                payload.put("title", req.getParameter("title"));
                payload.put("author", req.getParameter("author"));
                payload.put("isbn", req.getParameter("isbn"));
                payload.put("availableCopies", Integer.parseInt(req.getParameter("copies")));

                ApiClient.ApiResponse apiResp = ApiClient.put("/admin/books", payload, headers); 
                if (!apiResp.isSuccess()) error = apiResp.getMessage();

            } else if ("delete".equals(action)) {
                String id = req.getParameter("id");
                // Try query parameter first
                ApiClient.ApiResponse apiResp = ApiClient.delete("/admin/books?id=" + id, headers);
                
                // Fallback 1: Path parameter
                if (!apiResp.isSuccess()) {
                    ApiClient.ApiResponse pathResp = ApiClient.delete("/admin/books/" + id, headers);
                    if (pathResp.isSuccess()) apiResp = pathResp;
                }
                
                // Fallback 2: bookId parameter
                if (!apiResp.isSuccess()) {
                    ApiClient.ApiResponse bookIdResp = ApiClient.delete("/admin/books?bookId=" + id, headers);
                    if (bookIdResp.isSuccess()) apiResp = bookIdResp;
                }
                
                if (!apiResp.isSuccess()) error = apiResp.getMessage();
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "System error: " + e.getMessage();
        }

        if (error != null) {
            resp.sendRedirect(req.getContextPath() + "/books?error=" + URLEncoder.encode(error, StandardCharsets.UTF_8));
        } else {
            String msg = "Operation completed successfully.";
            resp.sendRedirect(req.getContextPath() + "/books?msg=" + URLEncoder.encode(msg, StandardCharsets.UTF_8));
        }
    }
}
