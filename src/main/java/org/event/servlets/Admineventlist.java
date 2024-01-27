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
import java.util.ArrayList;
import java.util.List;

import org.event.DBManager;
import org.event.models.Event;

/**
 * Servlet implementation class Admineventlist
 */
@WebServlet("/Admineventlist")
public class Admineventlist extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admineventlist() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection connection = DBManager.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM events");
			ResultSet resultSet = statement.executeQuery();
			List<Event> events = new ArrayList<>();
			while (resultSet.next()) {
				Event event = new Event();
				event.setEventId(resultSet.getInt("event_id"));
				event.setTitle(resultSet.getString("title"));
				event.setDescription(resultSet.getString("description"));
				event.setStartDate(resultSet.getDate("start_date"));
				event.setEndDate(resultSet.getDate("end_date"));
				event.setTime(resultSet.getString("time"));
				event.setLocation(resultSet.getString("location"));
				event.setPrice(resultSet.getFloat("price"));
				event.setOrganizerId(resultSet.getInt("organizer_id"));
				events.add(event);
			}
			request.setAttribute("events", events);
			request.getRequestDispatcher("Adminevent.jsp").forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
