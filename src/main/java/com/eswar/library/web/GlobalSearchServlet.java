package com.eswar.library.web;

import com.eswar.library.model.ExternalBook;
import com.eswar.library.util.ApiClient;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
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
import java.util.List;

@WebServlet("/globalSearch")
public class GlobalSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String query = req.getParameter("query");
        List<ExternalBook> results = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            try {
                String encodedQuery = URLEncoder.encode(query.trim(), StandardCharsets.UTF_8);
                // Explicitly request fields for better performance and to ensure we get what we need
                String url = "https://openlibrary.org/search.json?q=" + encodedQuery + "&limit=20&fields=title,author_name,cover_i,isbn,first_publish_year,key";
                
                ApiClient.ApiResponse apiResp = ApiClient.getExternal(url);
                if (apiResp.getStatusCode() == 200) {
                    JsonObject json = JsonParser.parseString(apiResp.getDataJson()).getAsJsonObject();
                    if (json.has("docs")) {
                        JsonArray docs = json.getAsJsonArray("docs");
                        Gson gson = new Gson();
                        Type listType = new TypeToken<ArrayList<ExternalBook>>(){}.getType();
                        results = gson.fromJson(docs, listType);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Error searching Open Library: " + e.getMessage());
            }
        }

        req.setAttribute("results", results);
        req.setAttribute("searchQuery", query);
        req.getRequestDispatcher("/jsp/globalSearch.jsp").forward(req, resp);
    }
}
