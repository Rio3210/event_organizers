package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import org.event.DBManager;
import org.event.models.*;


/**
 * Servlet implementation class GetAllEvents
 */
@WebServlet("/GetAllEvents")
public class GetAllEvents extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAllEvents() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = (HttpSession) request.getSession();
    	session.setAttribute("events", getAllEvents());
        request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
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
                event.setStartDate(resultSet.getDate("start_date"));
                event.setEndDate(resultSet.getDate("end_date"));
                event.setTime(resultSet.getString("time"));
                event.setLocation(resultSet.getString("location"));
                event.setOrganizerId(resultSet.getInt("organizer_id"));
                event.setPrice(resultSet.getFloat("price"));
                event.setImageUrl(resultSet.getString("image_url"));
                
                
                // Set other event details accordingly

                events.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exceptions accordingly
        }
        
        return events;
    }
}
