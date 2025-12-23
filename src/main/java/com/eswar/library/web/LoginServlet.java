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
import java.util.HashMap;
import java.util.Map;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        System.out.println("Login Attempt via API: " + username);

        Map<String, String> payload = new HashMap<>();
        payload.put("username", username);
        payload.put("password", password);

        try {
            ApiClient.ApiResponse apiResp = ApiClient.post("/auth/login", payload);

            if (apiResp.isSuccess()) {
                User user = apiResp.getData(User.class);
                System.out.println("User Found via API: " + user.getUsername() + ", Role: " + user.getRole());
                
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/dashboard");
                }
            } else {
                System.out.println("Login Failed via API: " + apiResp.getMessage());
                
                // Trigger Probe
               // com.eswar.library.util.BackendProbe.probe();
                
                req.setAttribute("errorMessage", apiResp.getMessage());
                req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "System error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
        }
    }
}
