package com.eswar.library.web;

import com.eswar.library.util.ApiClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Map<String, String> payload = new HashMap<>();
        payload.put("username", username);
        payload.put("password", password);
        payload.put("email", email);

        try {
            ApiClient.ApiResponse apiResp = ApiClient.post("/auth/signup", payload);

            if (apiResp.isSuccess()) {
                resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp?signupSuccess=true");
            } else {
                req.setAttribute("errorMessage", apiResp.getMessage());
                req.getRequestDispatcher("/jsp/signup.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "System error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/signup.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/signup.jsp").forward(req, resp);
    }
}