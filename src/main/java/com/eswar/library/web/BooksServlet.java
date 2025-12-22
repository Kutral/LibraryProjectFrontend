package com.eswar.library.web;

import com.eswar.library.model.Book;
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

@WebServlet("/books")
public class BooksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        String endpoint = "/books";
        if (query != null && !query.trim().isEmpty()) {
            endpoint += "?query=" + query.trim(); // URLEncoding is recommended in real apps
        }

        try {
            ApiClient.ApiResponse apiResp = ApiClient.get(endpoint);

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

            List<Book> books = new ArrayList<>();
            if (apiResp.isSuccess()) {
                String json = apiResp.getDataJson();
                if (json != null) {
                    Gson gson = new Gson();
                    Type bookListType = new TypeToken<ArrayList<Book>>(){}.getType();
                    books = gson.fromJson(json, bookListType);
                }
            }
            req.setAttribute("books", books);
            req.getRequestDispatcher("/jsp/books.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(req.getParameter("json"))) {
                resp.setStatus(500);
                resp.getWriter().write("{\"error\": \"Server error\"}");
            } else {
                throw new ServletException(e);
            }
        }
    }
}
