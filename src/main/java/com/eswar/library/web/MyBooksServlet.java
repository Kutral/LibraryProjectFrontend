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

@WebServlet("/myBooks")
public class MyBooksServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }

        try {
            // 1. Fetch all books to have access to ISBNs and full details
            ApiClient.ApiResponse booksResp = ApiClient.get("/books");
            Map<Integer, com.eswar.library.model.Book> booksMap = new HashMap<>();
            if (booksResp.isSuccess() && booksResp.getDataJson() != null) {
                Type bookListType = new TypeToken<ArrayList<com.eswar.library.model.Book>>(){}.getType();
                List<com.eswar.library.model.Book> allBooks = new Gson().fromJson(booksResp.getDataJson(), bookListType);
                for (com.eswar.library.model.Book b : allBooks) {
                    booksMap.put(b.getId(), b);
                }
            }

            // 2. Fetch borrowing history
            ApiClient.ApiResponse apiResp = ApiClient.get("/borrow?userId=" + user.getId());
            List<Borrow> activeLoans = new ArrayList<>();

            if (apiResp.isSuccess() && apiResp.getDataJson() != null) {
                Type listType = new TypeToken<ArrayList<Borrow>>(){}.getType();
                List<Borrow> allBorrows = new Gson().fromJson(apiResp.getDataJson(), listType);
                
                // Filter for books that haven't been returned yet
                activeLoans = allBorrows.stream()
                        .filter(b -> !b.isReturned() && b.getReturnDate() == null)
                        .map(b -> {
                            // Ensure the 'book' object is populated with full data (especially ISBN)
                            if (booksMap.containsKey(b.getBookId())) {
                                b.setBook(booksMap.get(b.getBookId()));
                            }
                            return b;
                        })
                        .sorted((b1, b2) -> {
                            if (b1.getBorrowDate() == null) return 1;
                            if (b2.getBorrowDate() == null) return -1;
                            return b2.getBorrowDate().compareTo(b1.getBorrowDate());
                        })
                        .collect(Collectors.toList());
            }

            req.setAttribute("activeLoans", activeLoans);
            req.getRequestDispatcher("/jsp/myBooks.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "System error: " + e.getMessage());
            req.getRequestDispatcher("/jsp/myBooks.jsp").forward(req, resp);
        }
    }
}
