package org.event.servlets;

import jakarta.servlet.RequestDispatcher;
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

/**
 * Servlet implementation class GetPersonalEvent
 * 
 */
@WebServlet("/GetPersonalEvents")
public class GetPersonalEvent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPersonalEvent() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
	    int organizerId = (int) session.getAttribute("organizer_id");
		
	    
	    // Code to fetch event related to the organizer_id
		
	    
	    // Set the event as an attribute to be accessed by the JSP or further processing
	    request.setAttribute("event", fetchEventByOrganizerId(organizerId));
	    
	    // Forward the request to a JSP or perform further processing
	    RequestDispatcher dispatcher = request.getRequestDispatcher("/myevents.jsp");
	    dispatcher.forward(request, response);
	}
	
	private List<Event> fetchEventByOrganizerId(int organizerId) {
	    List<Event> events = new ArrayList<>();
	    try (Connection connection = DBManager.getConnection()) {
	        // Build and execute a SQL query to fetch the events with the given organizer_id
	        String query = "SELECT * FROM events WHERE organizer_id = ?";
	        try (PreparedStatement statement = connection.prepareStatement(query)) {
	            statement.setInt(1, organizerId);

	            try (ResultSet resultSet = statement.executeQuery()) {
	                while (resultSet.next()) {
	                    // Retrieve event details from the result set
	                    int eventId = resultSet.getInt("event_id");
	                    String title = resultSet.getString("title");
	                    String description = resultSet.getString("description");
	                    
	                    // Retrieve other event properties as needed

	                    // Create the Event object
	                    Event event = new Event();
	                    event.setEventId(eventId);
	                    event.setTitle(title);
	                    event.setDescription(description);
	                    
	                    // Set other event properties as needed

	                    // Add the event to the list
	                    events.add(event);
	                }
	            }
	        }
	    } catch (SQLException e) {
	        throw new RuntimeException("Failed to fetch events from the database.", e);
	    }

	    return events;
	}
}
