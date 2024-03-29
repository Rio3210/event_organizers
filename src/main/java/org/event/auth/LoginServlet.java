package org.event.auth;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import org.event.DBManager;
import org.event.servlets.GetAllEvents;
import org.event.models.Event;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Connection con = null;
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		
		if (email == null || email.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
		else if (password == null || password.equals("")) {
			request.setAttribute("status", "invalid");
			dispatcher=request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
		else {
			try {
			    Connection conn = DBManager.getConnection();
			    PreparedStatement pst = conn.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
			    pst.setString(1, email);
			    pst.setString(2, password);

			    ResultSet rs = pst.executeQuery();

			    if (rs.next()) {
			        session.setAttribute("email", rs.getString("email"));
			        session.setAttribute("organizer_id", rs.getInt("user_id"));
			        session.setAttribute("image_url", rs.getString("image_url"));
			        GetAllEvents getAllEventsServlet = new GetAllEvents();
			        List<Event> events = getAllEventsServlet.getAllEvents();
			        session.setAttribute("events", events);

			        String role = rs.getString("role");
			        session.setAttribute("role", role);
			        if (role.equals("admin")) {
			            response.sendRedirect("adminlanding"); 
			        } else {
			            response.sendRedirect("index.jsp"); 
			        }
			    } else {
			        request.setAttribute("status", "failed");
			        dispatcher = request.getRequestDispatcher("login.jsp");
			        dispatcher.forward(request, response);
			    }
			} catch (Exception e) {
			    e.printStackTrace();
			}
		}

	
	}

}
