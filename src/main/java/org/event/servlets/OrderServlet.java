package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;



import org.event.DBManager;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // Retrieve the user_id and event_id from the query string
	    String input = request.getParameter("user_id");
	    int startIndex = input.indexOf("event_id=");
	
		 // Extract the substring from the start index to the end
		 String userIdSubstring = input.substring(0, startIndex);
		 String eventIdSubstring = input.substring(startIndex + "event_id=".length());
	
		 // Convert the substrings to integers if needed
		 int userId = Integer.parseInt(userIdSubstring);
		 int eventId = Integer.parseInt(eventIdSubstring);
	    System.out.println("User ID: " + userId);
        System.out.println("Event ID: " + eventId);

	    // Insert the order into the order table
	    try (Connection connection = DBManager.getConnection()) {
	        String sql = "INSERT INTO orders (user_id, event_id) VALUES (?, ?)";
	        PreparedStatement statement = connection.prepareStatement(sql);
	        statement.setInt(1, userId);
	        statement.setInt(2, eventId);
	        statement.executeUpdate();

	        // Redirect to order.jsp
	        response.sendRedirect("order.jsp");
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle any errors
	    }
	}
    
}