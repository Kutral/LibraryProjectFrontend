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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/admin/borrows")
public class AdminBorrowsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        List<Borrow> allBorrows = new ArrayList<>();
        Map<Integer, User> userMap = new HashMap<>();
        String error = null;

        try {
            // 1. Fetch all users
            ApiClient.ApiResponse userResp = ApiClient.get("/admin/users");
            if (!userResp.isSuccess()) {

                 userResp = ApiClient.get("/users");
            }

            if (userResp.isSuccess()) {
                String json = userResp.getDataJson();
                if (json != null) {
                    Type userListType = new TypeToken<ArrayList<User>>(){}.getType();
                    List<User> users = new Gson().fromJson(json, userListType);

                    userMap = users.stream().collect(Collectors.toMap(User::getId, u -> u));

                    // 2. For each user, fetch their borrows
                    for (User user : users) {
                        try {
                            ApiClient.ApiResponse borrowResp = ApiClient.get("/borrow?userId=" + user.getId());
                            if (borrowResp.isSuccess() && borrowResp.getDataJson() != null) {
                                Type borrowListType = new TypeToken<ArrayList<Borrow>>(){}.getType();
                                List<Borrow> userBorrows = new Gson().fromJson(borrowResp.getDataJson(), borrowListType);
                                if (userBorrows != null) {
                                    allBorrows.addAll(userBorrows);
                                }
                            }
                        } catch (Exception innerEx) {

                            innerEx.printStackTrace();
                        }
                    }
                }
            } else {
                error = "Failed to fetch users list: " + userResp.getMessage();
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "System error: " + e.getMessage();
        }

       //sort
        allBorrows.sort((b1, b2) -> {
            if (b1.getBorrowDate() == null) return 1;
            if (b2.getBorrowDate() == null) return -1;
            return b2.getBorrowDate().compareTo(b1.getBorrowDate());
        });

        req.setAttribute("borrows", allBorrows);
        req.setAttribute("userMap", userMap);
        if (error != null) {
            req.setAttribute("error", error);
        }
        
        req.getRequestDispatcher("/jsp/admin_borrows.jsp").forward(req, resp);
    }
}