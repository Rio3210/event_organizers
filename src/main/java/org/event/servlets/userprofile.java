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


/**
 * Servlet implementation class userprofile
 */
@WebServlet("/userprofile")
public class userprofile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userprofile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int organizerId = (int) session.getAttribute("organizer_id");
		System.out.println("letsgooooo");
		System.out.println(organizerId);
		
		String first_name = request.getParameter("firstName");
		String last_name = request.getParameter("lastName");
		String username = request.getParameter("username");	
	
		System.out.println(first_name);
		System.out.println(last_name);
		System.out.println(username);
		
		
		Connection connection = null;
        try {
            connection = org.event.DBManager.getConnection();

          
            String query = "UPDATE users SET firstname = ?, lastname = ?,username = ? WHERE user_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, first_name);
                stmt.setString(2, last_name);
                stmt.setString(3, username);
                stmt.setInt(4, organizerId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("User information updated successfully");
                } else {
                    System.out.println("No user found with the specified ID");
                }
                response.sendRedirect("profile.jsp");
            }
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (Exception e) {
                    System.out.println(e);
                }
            }
        }
	}

}
