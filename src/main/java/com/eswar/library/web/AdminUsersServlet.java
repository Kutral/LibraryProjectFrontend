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
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = new ArrayList<>();
        try {
            ApiClient.ApiResponse apiResp = ApiClient.get("/users");
            
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
}