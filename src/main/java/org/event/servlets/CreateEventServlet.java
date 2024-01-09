package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.event.DBManager;
import org.event.models.*;

@WebServlet("/CreateEventServlet")
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doget(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = (HttpSession) request.getSession();
    	session.setAttribute("events", getAllEvents());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = (HttpSession) request.getSession();
        int organizerId = (int) session.getAttribute("organizer_id");
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDateString = request.getParameter("start_date");
        String endDateString = request.getParameter("end_date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");
        float price = Float.parseFloat(request.getParameter("price")); // Parse the price from the request

        try (Connection conn = DBManager.getConnection()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date startDate =  sdf.parse(startDateString);
            java.util.Date endDate = sdf.parse(endDateString);

            String sql = "INSERT INTO events (title, description, start_date, end_date, time, location, organizer_id, price) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, description);
                statement.setDate(3, new java.sql.Date(startDate.getTime()));
                statement.setDate(4, new java.sql.Date(endDate.getTime()));
                statement.setString(5, time);
                statement.setString(6, location);
                statement.setInt(7, organizerId);
                statement.setFloat(8, price);

                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                    session.setAttribute("message", "Event created successfully!");
                } else {
                    session.setAttribute("message", "Failed to create the event. Please try again.");
                }

                response.sendRedirect("createevent.jsp");
            }
        } catch (ParseException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "An error occurred. Please try again.");
            response.sendRedirect("createevent.jsp");
        }
    }
    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();

        try (Connection conn = DBManager.getConnection();
             PreparedStatement statement = conn.prepareStatement("SELECT * FROM events");
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Event event = new Event();
                event.setEventId(resultSet.getInt("event_id"));
                event.setTitle(resultSet.getString("title"));
                event.setDescription(resultSet.getString("description"));
                
                
                
                // Set other event details accordingly

                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions accordingly
        }
        System.out.println(events);
        return events;
    }


}

