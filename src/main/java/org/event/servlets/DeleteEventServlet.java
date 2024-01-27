package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.event.DBManager;

/**
 * Servlet implementation class DeleteEventServlet
 */
@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Check if the event has been ordered by any user
        if (hasOrders(eventId)) {
            // If there are orders, show a pop-up message
        	// In your servlet
        	request.setAttribute("errorMessage", "Event cannot be deleted. It has been ordered by users. Please Contact the Admin");
        	request.setAttribute("backUrl", "GetPersonalEvents"); // Specify the appropriate URL to go back to
        	request.getRequestDispatcher("/error.jsp").forward(request, response);

        }

        // If no orders, proceed to delete the event
        deleteEvent(eventId);

        // Redirect to the page showing events (e.g., My Events or Orders)
        response.sendRedirect("GetPersonalEvents");
    }

    private boolean hasOrders(int eventId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBManager.getConnection();

            // Prepare the SQL statement to check if the event has orders
            String sql = "SELECT COUNT(*) FROM orders WHERE event_id = ?";
            statement = connection.prepareStatement(sql);

            // Set the parameter value
            statement.setInt(1, eventId);

            // Execute the query
            resultSet = statement.executeQuery();

            // Check if there are orders for the event
            if (resultSet.next()) {
                int orderCount = resultSet.getInt(1);
                return orderCount > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the result set, statement, and connection
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Default to false in case of an error
        return false;
    }

    private void deleteEvent(int eventId) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = DBManager.getConnection();

            // Prepare the SQL statement to delete the event
            String sql = "DELETE FROM events WHERE event_id = ?";
            statement = connection.prepareStatement(sql);

            // Set the parameter value
            statement.setInt(1, eventId);

            // Execute the delete
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the statement and connection
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}