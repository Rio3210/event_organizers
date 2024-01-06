package org.event.auth;

import jakarta.servlet.RequestDispatcher;
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

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public RegistrationServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("pass");
		String confirmPassword = request.getParameter("re_pass");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		if (password == null || password.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
		}
		else if (email == null || email.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
		}
		else if (username == null || username.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
		}
		else if (!password.equals(confirmPassword)) {
			request.setAttribute("status", "confirm_password_invalid");
			dispatcher=request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request, response);
			
		}
		else {
		    try {
		    	Connection conn = DBManager.getConnection();
		        
		        PreparedStatement checkEmailStmt = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE email = ?");
		        checkEmailStmt.setString(1, email);
		        ResultSet resultSet = checkEmailStmt.executeQuery();
		        resultSet.next();
		        int emailCount = resultSet.getInt(1);

		        if (emailCount > 0) {
		            
		            request.setAttribute("status", "duplicate_email");
		            dispatcher = request.getRequestDispatcher("registration.jsp");
		            dispatcher.forward(request, response);
		        } else {
		          
		            PreparedStatement pst = conn.prepareStatement("INSERT INTO users(username, password, email) VALUES (?, ?, ?)");
		            pst.setString(1, username);
		            pst.setString(2, password);
		            pst.setString(3, email);

		            int rowCount = pst.executeUpdate();

		            

		            if (rowCount > 0) {
		                request.setAttribute("status", "success");
		                dispatcher = request.getRequestDispatcher("login.jsp");
		                
		            } else {
		                request.setAttribute("status", "failed");
		                dispatcher = request.getRequestDispatcher("registration.jsp");
		            }
		            dispatcher.forward(request, response);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (con!= null) {
		                con.close();
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		}

		
	}

}
