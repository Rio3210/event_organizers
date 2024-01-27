package org.event.servlets;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.event.DBManager;
import org.event.models.*;
import jakarta.servlet.http.Part;
/**
 * Servlet implementation class UpdateEventServlet
 */
@WebServlet("/UpdateEventServlet")
@MultipartConfig
public class UpdateEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateEventServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    HttpSession session = request.getSession();
	 
	    
	    // Retrieve the updated event details from the form
	    int eventId = Integer.parseInt(request.getParameter("eventId"));
	    String title = request.getParameter("title");
	    String description = request.getParameter("description");
	    String startDateString = request.getParameter("start_date");
	    String endDateString = request.getParameter("end_date");
	    String time = request.getParameter("time");
	    String location = request.getParameter("location");
	    float price = Float.parseFloat(request.getParameter("price"));

	    // Retrieve the updated image file if it's provided
	    Part part = request.getPart("image");
	    String imagefile = null;
	    if (part != null && part.getSize() > 0) {
	        // Handle image upload
	        imagefile = part.getSubmittedFileName();
	        String uploadpath = "E:/eclipse/event_organizer/src/main/webapp/images/" + imagefile;

	        try {
	            // Save the uploaded image
	            FileOutputStream fos = new FileOutputStream(uploadpath);
	            InputStream is = part.getInputStream();
	            byte[] data = new byte[is.available()];
	            is.read(data);
	            fos.write(data);
	            fos.close();
	            System.out.println("Image upload successful");
	        } catch (Exception e) {
	            e.printStackTrace();
	            session.setAttribute("message", "Failed to upload the image. Please try again.");
	            response.sendRedirect("editevent.jsp");
	            return;
	        }
	    }

	    try (Connection conn = DBManager.getConnection()) {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date startDate = sdf.parse(startDateString);
	        java.util.Date endDate = sdf.parse(endDateString);

	        // Update the event details in the database
	        String sql = "UPDATE events SET title=?, description=?, start_date=?, end_date=?, time=?, location=?, price=?, image_url=? WHERE event_id=?";
	        try (PreparedStatement statement = conn.prepareStatement(sql)) {
	            statement.setString(1, title);
	            statement.setString(2, description);
	            statement.setDate(3, new java.sql.Date(startDate.getTime()));
	            statement.setDate(4, new java.sql.Date(endDate.getTime()));
	            statement.setString(5, time);
	            statement.setString(6, location);
	            statement.setFloat(7, price);

	            // Set the image URL only if an image is uploaded
	            if (part != null && part.getSize() > 0) {
	                statement.setString(8, imagefile);
	            } else {
	                statement.setString(8, null); // Set to null if no new image is uploaded
	            }

	            statement.setInt(9, eventId);

	            int rowsAffected = statement.executeUpdate();

	            if (rowsAffected > 0) {
	                // Successful update
	                session.setAttribute("message", "Event updated successfully!");
	            } else {
	                // Failed to update
	                session.setAttribute("message", "Failed to update the event. Please try again.");
	            }
	        }
	    } catch (ParseException | SQLException e) {
	        e.printStackTrace();
	        session.setAttribute("message", "An error occurred. Please try again.");
	    }

	    // Redirect back to the edit page with the updated event
	    response.sendRedirect("editevent.jsp");
	}

}
