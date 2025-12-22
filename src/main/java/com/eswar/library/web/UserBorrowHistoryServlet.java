package com.eswar.library.web;

import com.eswar.library.model.Borrow;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/history")
public class UserBorrowHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            if ("true".equals(req.getParameter("json"))) {
                resp.setStatus(401);
                resp.getWriter().write("{\"error\": \"Unauthorized\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
            // Fetch history for the logged-in user
            ApiClient.ApiResponse apiResp = ApiClient.get("/borrow?userId=" + user.getId());

            // JSON Response for AJAX
            if ("true".equals(req.getParameter("json"))) {
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                if (apiResp.isSuccess()) {
                    resp.getWriter().write(apiResp.getDataJson());
                } else {
                    resp.setStatus(apiResp.getStatusCode());
                    resp.getWriter().write("{\"error\": \"" + apiResp.getMessage() + "\"}");
                }
                return;
            }

            // Standard JSP Rendering
            List<Borrow> history = new ArrayList<>();
            if (apiResp.isSuccess()) {
                 String json = apiResp.getDataJson();
                 if (json != null) {
                     Type listType = new TypeToken<ArrayList<Borrow>>(){}.getType();
                     history = new Gson().fromJson(json, listType);
                 }
            } else {
                req.setAttribute("errorMessage", "Failed to load history: " + apiResp.getMessage());
            }
            req.setAttribute("history", history);
            req.getRequestDispatcher("/jsp/userHistory.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(req.getParameter("json"))) {
                 resp.setStatus(500);
                 resp.getWriter().write("{\"error\": \"System error\"}");
            } else {
                req.setAttribute("errorMessage", "System error: " + e.getMessage());
                req.getRequestDispatcher("/jsp/userHistory.jsp").forward(req, resp);
            }
        }
    }
}
