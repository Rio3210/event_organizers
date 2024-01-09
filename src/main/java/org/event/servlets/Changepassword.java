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
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.event.DBManager;

/**
 * Servlet implementation class Changepassword
 */
@WebServlet("/changepasswordservlet")
public class Changepassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Changepassword() {
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
		String newPassword = request.getParameter("newPassword");
		String confirmPassword = request.getParameter("confirmPassword");
		System.out.println(confirmPassword);
		
		HttpSession session = request.getSession();
		
		RequestDispatcher dispatcher = null;
		
		if (newPassword == null || newPassword.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("profile.jsp");
			dispatcher.forward(request, response);
			System.out.println("error");
		}
		else if (confirmPassword  == null || confirmPassword.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("profile.jsp");
			dispatcher.forward(request, response);
			System.out.println("error");
		}
		else if (!(confirmPassword.equals(newPassword))) {
			request.setAttribute("status", "missmatch");
			dispatcher=request.getRequestDispatcher("profile.jsp");
			dispatcher.forward(request, response);
			System.out.println("error");
		}
		else {
			Connection connection = null;
			try {
				connection = DBManager.getConnection();
	            
	    		int organizerId = (int) session.getAttribute("organizer_id");
	            int userId = organizerId;

	            String query = "UPDATE users SET password = ? WHERE user_id = ?";

				
		    	
		        System.out.println("heres");
				Connection conn = DBManager.getConnection();
				PreparedStatement pst = conn.prepareStatement("UPDATE users SET password = ? WHERE user_id = ?");
				pst.setString(1, confirmPassword);
				pst.setInt(2, userId);
				
				 try (PreparedStatement stmt = connection.prepareStatement(query)) {
		                stmt.setString(1, confirmPassword);
		                stmt.setInt(2, userId);
		                
		                int rowsUpdated = stmt.executeUpdate();

		                if (rowsUpdated > 0) {
		                	System.out.println("password reseted");
		                	request.setAttribute("status", "resetSuccess");
						    dispatcher = request.getRequestDispatcher("profile.jsp");
						    dispatcher.forward(request, response);
		                } else {
		                	request.setAttribute("status", "failed");
						    dispatcher = request.getRequestDispatcher("profile.jsp");
						    dispatcher.forward(request, response);
		                }
		            }
		        } catch (Exception e) {
		            System.out.println(e);
		        }
					
		}

	}

}
