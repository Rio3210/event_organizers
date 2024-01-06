package org.event.auth;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AuthenticationFilter implements Filter {

    private String loginPage = "login.jsp"; // Update with your actual login page URL

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Check if the user is accessing the login page
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.endsWith(loginPage)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if the user is logged in
        if (isUserLoggedIn(httpRequest)) {
            // User is logged in, allow access to the requested page
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to the login page
            httpResponse.sendRedirect(loginPage);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }

    private boolean isUserLoggedIn(HttpServletRequest request) {
        // Check if the user is logged in based on your authentication mechanism
        // You can check session attributes, cookies, or any other authentication data

        // For example, checking if a session attribute is present
        return request.getSession().getAttribute("organizer_id") != null;
    }
}