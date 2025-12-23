package com.eswar.library.web;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // 1. Prevent Browser Caching for all pages
        // This is key to fixing the "back button" issue
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        res.setDateHeader("Expires", 0); // Proxies.

        // 2. Allow access to login, signup, and public assets
        boolean loggedIn = (session != null && session.getAttribute("user") != null);
        boolean isPublicResource = path.startsWith("/jsp/login.jsp") || 
                                   path.startsWith("/jsp/signup.jsp") || 
                                   path.startsWith("/login") || 
                                   path.startsWith("/signup") || 
                                   path.startsWith("/css/") || 
                                   path.equals("/") || 
                                   path.equals("/index.jsp");

        if (loggedIn || isPublicResource) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
        }
    }
}
