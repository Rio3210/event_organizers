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
import org.event.models.Event;

@WebServlet("/EventUpdateHelper")
public class EventUpdateHelper extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve event ID from the submitted form
        String eventId = request.getParameter("eventId");

        // Fetch event data based on the event ID (you need to implement this method)
        Event event = fetchEventById(eventId);

        // Set the event data as an attribute in the request
        request.setAttribute("editevent", event);

        // Forward the request to editevent.jsp
        request.getRequestDispatcher("/editevent.jsp").forward(request, response);
    }

    // You need to implement this method to fetch the event by ID from your data source
    public Event fetchEventById(String eventId) {
        Event event = null;
        String sql = "SELECT * FROM events WHERE event_id = ?";
        
        try (Connection connection = DBManager.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            
            preparedStatement.setInt(1, Integer.parseInt(eventId));
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                event = new Event();
                event.setEventId(resultSet.getInt("event_id"));
                event.setTitle(resultSet.getString("title"));
                event.setDescription(resultSet.getString("description"));
                event.setStartDate(resultSet.getDate("start_date"));
                event.setEndDate(resultSet.getDate("end_date"));
                event.setTime(resultSet.getString("time"));
                event.setLocation(resultSet.getString("location"));
                event.setPrice(resultSet.getFloat("price"));
                event.setImageUrl(resultSet.getString("image_url"));
                
            }

        } catch (SQLException e) {
            // Handle any SQL exceptions appropriately
            e.printStackTrace();
        }

        return event;
    }
}
