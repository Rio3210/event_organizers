package org.event.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import org.event.DBManager;
import org.event.models.Event;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userdelete")
public class UserDelete extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	Integer userId = Integer.parseInt(request.getParameter("userId") != null ? request.getParameter("userId") : session.getAttribute("organizer_id").toString());
        
        RequestDispatcher dispatcher = null;
        // Delete user account and related data
        
        boolean success = deleteUserAccount(userId);
        GetPersonalEvent getPersonalEventsServlet = new GetPersonalEvent();
        List<Event> events = getPersonalEventsServlet.fetchEventByOrganizerId((int) session.getAttribute("organizer_id"));
        if (session.getAttribute("role").equals("normal") && !events.isEmpty()) {
            request.setAttribute("errorMessage", "You cannot delete your account as you have created events. Contact the Admin");
            request.setAttribute("backUrl", "profile.jsp");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } else if (success) {
            request.setAttribute("status", "Account Deleted Successfully");
            if (session.getAttribute("role").equals("admin")) {
                dispatcher = request.getRequestDispatcher("adminuserget");
            } else {
                dispatcher = request.getRequestDispatcher("login.jsp");
            }

            dispatcher.forward(request, response);
        } else {
            request.setAttribute("status", "Account Deletion Failed");
            dispatcher = request.getRequestDispatcher("profile.jsp");
            dispatcher.forward(request, response);
        }
    }

    private boolean deleteUserAccount(int userId) {
        try (Connection connection = DBManager.getConnection()) {
            connection.setAutoCommit(false); // Begin transaction

            // Step 1: Delete orders related to the user account
            deleteOrders(connection, userId);

            // Step 2: Delete events related to the user account
            deleteEvents(connection, userId);

            // Step 3: Delete the user account itself
            boolean success = deleteUser(connection, userId);

            if (success) {
                connection.commit(); // Commit transaction
            } else {
                connection.rollback(); // Rollback transaction
            }

            return success;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void deleteOrders(Connection connection, int userId) throws SQLException {
        String deleteOrdersQuery = "DELETE FROM orders WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(deleteOrdersQuery)) {
            statement.setInt(1, userId);
            statement.executeUpdate();
        }
    }

    private void deleteEvents(Connection connection, int userId) throws SQLException {
        String deleteEventsQuery = "DELETE FROM events WHERE organizer_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(deleteEventsQuery)) {
            statement.setInt(1, userId);
            statement.executeUpdate();
        }
    }

    private boolean deleteUser(Connection connection, int userId) throws SQLException {
        String deleteUserQuery = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(deleteUserQuery)) {
            statement.setInt(1, userId);
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }
}