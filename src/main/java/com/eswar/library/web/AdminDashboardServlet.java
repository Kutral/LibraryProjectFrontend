package com.eswar.library.web;

import com.eswar.library.model.User;
import com.eswar.library.util.ApiClient;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        Map<String, Object> stats = new HashMap<>();
        boolean publicApiWorking = false;

        try {
            // 1. Fetch Backend Stats
            Map<String, String> headers = new HashMap<>();
            headers.put("X-User-ID", String.valueOf(user.getId()));
            ApiClient.ApiResponse statsResp = ApiClient.get("/admin/stats", headers);
            
            if (statsResp.isSuccess() && statsResp.getDataJson() != null) {
                JsonObject data = JsonParser.parseString(statsResp.getDataJson()).getAsJsonObject();
                stats.put("totalUsers", data.get("totalUsers").getAsInt());
                stats.put("totalBooks", data.get("totalBooks").getAsInt());
                stats.put("activeBorrows", data.get("activeBorrows").getAsInt());
            } else {
                req.setAttribute("error", "Failed to fetch stats: " + statsResp.getMessage());
            }

            // 2. Check Open Library API (Public Library API)
            try {
                ApiClient.ApiResponse publicApiResp = ApiClient.getExternal("https://openlibrary.org/search.json?q=test&limit=1");
                if (publicApiResp.getStatusCode() == 200) {
                    publicApiWorking = true;
                }
            } catch (Exception e) {
                System.err.println("Public API Check failed: " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "System error: " + e.getMessage());
        }

        req.setAttribute("stats", stats);
        req.setAttribute("publicApiWorking", publicApiWorking);
        req.getRequestDispatcher("/jsp/adminDashboard.jsp").forward(req, resp);
    }
}
