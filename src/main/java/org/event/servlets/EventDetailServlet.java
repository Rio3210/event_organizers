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
import org.event.models.*;

/**
 * Servlet implementation class EventDetailServlet
 */

@WebServlet("/EventDetailServlet")
public class EventDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EventDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setHeader("Access-Control-Allow-Origin", "http://localhost:8088");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        // Retrieve the event ID from the request
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Fetch the event details from the database
        Event event = fetchEventById(eventId);

        // Set the event object as an attribute in the request
        request.setAttribute("eventdetail", event);

        // Forward the request to the event details JSP
        request.getRequestDispatcher("eventdetail.jsp").forward(request, response);
    }

    private Event fetchEventById(int eventId) {
        Event event = null;
        try (Connection connection = DBManager.getConnection()) {
            // Build and execute a SQL query to fetch the event with the given event ID
            String query = "SELECT * FROM events WHERE event_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, eventId);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Retrieve event details from the result set
                        String title = resultSet.getString("title");
                        String description = resultSet.getString("description");
                        float price = resultSet.getFloat("price");
                        // Retrieve other event properties as needed

                        // Create the Event object
                        event = new Event();
                        event.setEventId(eventId);
                        event.setTitle(title);
                        event.setDescription(description);
                        event.setPrice(price);
                        // Set other event properties as needed
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to fetch event from the database.", e);
        }

        return event;
    }

}
