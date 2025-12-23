package com.eswar.library.web;

import com.eswar.library.model.BookRequest;
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

@WebServlet("/requests")
public class RequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
            ApiClient.ApiResponse apiResp;
            if ("ADMIN".equals(user.getRole())) {
                Map<String, String> headers = new HashMap<>();
                headers.put("X-User-ID", String.valueOf(user.getId()));
                apiResp = ApiClient.get("/admin/requests", headers);
            } else {
                apiResp = ApiClient.get("/requests?userId=" + user.getId());
            }

            List<BookRequest> requests = new ArrayList<>();
            if (apiResp.isSuccess() && apiResp.getDataJson() != null) {
                Type listType = new TypeToken<ArrayList<BookRequest>>(){}.getType();
                requests = new Gson().fromJson(apiResp.getDataJson(), listType);
            }

            req.setAttribute("bookRequests", requests);
            String jspPath = "ADMIN".equals(user.getRole()) ? "/jsp/admin_requests.jsp" : "/jsp/user_requests.jsp";
            req.getRequestDispatcher(jspPath).forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to load requests: " + e.getMessage());
            req.getRequestDispatcher("/jsp/dashboard.jsp").forward(req, resp);
        }
    }

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
        String msg = null;

        try {
            if ("create".equals(action)) {
                Map<String, Object> payload = new HashMap<>();
                payload.put("userId", user.getId());
                payload.put("title", req.getParameter("title"));
                payload.put("author", req.getParameter("author"));
                payload.put("isbn", req.getParameter("isbn"));
                
                ApiClient.ApiResponse apiResp = ApiClient.post("/requests", payload);
                if (apiResp.isSuccess()) msg = "Request submitted successfully!";
                else error = apiResp.getMessage();

            } else if ("approve".equals(action) || "reject".equals(action)) {
                if (!"ADMIN".equals(user.getRole())) {
                    resp.sendError(403);
                    return;
                }
                String requestId = req.getParameter("requestId");
                Map<String, Object> payload = new HashMap<>();
                payload.put("status", "approve".equals(action) ? "APPROVED" : "REJECTED");
                
                Map<String, String> headers = new HashMap<>();
                headers.put("X-User-ID", String.valueOf(user.getId()));
                
                ApiClient.ApiResponse apiResp = ApiClient.put("/admin/requests/" + requestId, payload, headers);
                if (apiResp.isSuccess()) msg = "Request " + action + "ed successfully!";
                else error = apiResp.getMessage();
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "System error: " + e.getMessage();
        }

        String redirect = req.getContextPath() + "/requests";
        if (error != null) redirect += "?error=" + URLEncoder.encode(error, StandardCharsets.UTF_8);
        if (msg != null) redirect += "?msg=" + URLEncoder.encode(msg, StandardCharsets.UTF_8);
        resp.sendRedirect(redirect);
    }
}
