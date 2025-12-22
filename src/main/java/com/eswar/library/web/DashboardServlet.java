package com.eswar.library.web;

import com.eswar.library.model.Book;
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
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        // 1. Fetch Books
        List<Book> books = new ArrayList<>();
        String query = req.getParameter("query");
        String booksEndpoint = "/books";
        if (query != null && !query.trim().isEmpty()) {
            booksEndpoint += "?query=" + query.trim();
        }

        try {
            ApiClient.ApiResponse booksResp = ApiClient.get(booksEndpoint);
            if (booksResp.isSuccess() && booksResp.getDataJson() != null) {
                Gson gson = new Gson();
                Type bookListType = new TypeToken<ArrayList<Book>>(){}.getType();
                books = gson.fromJson(booksResp.getDataJson(), bookListType);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to fetch books.");
        }

        // 2. Fetch History & Identify Active Borrows
        List<Borrow> history = new ArrayList<>();
        Set<Integer> activeBookIds = new HashSet<>();
        try {
            ApiClient.ApiResponse historyResp = ApiClient.get("/borrow?userId=" + user.getId());
            if (historyResp.isSuccess() && historyResp.getDataJson() != null) {
                Gson gson = new Gson();
                Type listType = new TypeToken<ArrayList<Borrow>>(){}.getType();
                history = gson.fromJson(historyResp.getDataJson(), listType);
                
                for (Borrow b : history) {
                    if (b.getReturnDate() == null) {
                        activeBookIds.add(b.getBookId());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("books", books);
        req.setAttribute("history", history);
        req.setAttribute("activeBookIds", activeBookIds);
        req.setAttribute("searchQuery", query);
        
        req.getRequestDispatcher("/jsp/dashboard.jsp").forward(req, resp);
    }
}
