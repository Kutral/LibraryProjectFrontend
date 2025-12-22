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

@WebServlet("/borrowBook")
public class BorrowBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String error = null;
        String message = null;

        try {
            if ("return".equals(action)) {
                // Return Book Logic
                String borrowIdStr = req.getParameter("borrowId");
                if (borrowIdStr != null) {
                    int borrowId = Integer.parseInt(borrowIdStr);
                    Map<String, Object> payload = new HashMap<>();
                    payload.put("borrowId", borrowId);
                    
                    ApiClient.ApiResponse apiResp = ApiClient.put("/borrow", payload);
                    if (apiResp.isSuccess()) {
                        message = "Book returned successfully.";
                    } else {
                        error = apiResp.getMessage();
                    }
                }
            } else {
                // Borrow Book Logic (Default)
                String bookIdStr = req.getParameter("bookId");
                if (bookIdStr != null) {
                    int bookId = Integer.parseInt(bookIdStr);
                    Map<String, Object> payload = new HashMap<>();
                    payload.put("userId", user.getId());
                    payload.put("bookId", bookId);

                    ApiClient.ApiResponse apiResp = ApiClient.post("/borrow", payload);
                    if (apiResp.isSuccess()) {
                         message = "Book borrowed successfully.";
                    } else {
                        error = apiResp.getMessage();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "System error: " + e.getMessage();
        }

        // Redirect back to dashboard
        StringBuilder redirectUrl = new StringBuilder(req.getContextPath() + "/dashboard");
        if (error != null) {
            redirectUrl.append("?error=").append(URLEncoder.encode(error, StandardCharsets.UTF_8));
        } else if (message != null) {
             redirectUrl.append("?msg=").append(URLEncoder.encode(message, StandardCharsets.UTF_8));
        }
        
        resp.sendRedirect(redirectUrl.toString());
    }
}
