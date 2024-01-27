package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.event.DBManager;

/**
 * Servlet implementation class Adminnews
 */
@WebServlet("/adminnews")
public class Adminnews extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Adminnews() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		
		System.out.println(title);
		System.out.println(description);
		
		try (Connection conn = DBManager.getConnection()) {

			String sql = "INSERT INTO news (title, description) " + "VALUES (?, ?)";
			try (PreparedStatement statement = conn.prepareStatement(sql)) {
				statement.setString(1, title);
				statement.setString(2, description);
				int rowsAffected = statement.executeUpdate();

				if (rowsAffected > 0) {
					response.sendRedirect("Adminpage.jsp");
				}
			}
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

}
