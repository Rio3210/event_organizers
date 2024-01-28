package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.event.DBManager;
import org.event.models.*;

@WebServlet("/adminlanding")
public class AdminLanding extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminLanding() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the necessary data for the dashboard
        int totalUsers = getTotalUsers();
        int totalEvents = getTotalEvents();
        int totalOrders = getTotalOrders();
        double totalRevenue = getTotalRevenue();

        // Set the data as request attributes
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalRevenue", totalRevenue);

        // Forward the request to the JSP
        request.getRequestDispatcher("adminhome.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Retrieve total number of users from the database
    private int getTotalUsers() {
        int totalUsers = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getConnection();
            stmt = conn.prepareStatement("SELECT COUNT(*) AS totalUsers FROM users");
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalUsers = rs.getInt("totalUsers");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return totalUsers;
    }

    // Retrieve total number of events from the database
    private int getTotalEvents() {
        int totalEvents = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getConnection();
            stmt = conn.prepareStatement("SELECT COUNT(*) AS totalEvents FROM events");
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalEvents = rs.getInt("totalEvents");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return totalEvents;
    }

    // Retrieve total number of orders from the database
    private int getTotalOrders() {
        int totalOrders = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getConnection();
            stmt = conn.prepareStatement("SELECT COUNT(*) AS totalOrders FROM orders");
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalOrders = rs.getInt("totalOrders");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return totalOrders;
    }

    // Retrieve total revenue from the database
    private double getTotalRevenue() {
        double totalRevenue = 0.0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getConnection();
            stmt = conn.prepareStatement("SELECT SUM(e.price) AS totalRevenue "
                    + "FROM events e JOIN orders o ON e.event_id = o.event_id");
            rs = stmt.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getDouble("totalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return totalRevenue;
    }
}