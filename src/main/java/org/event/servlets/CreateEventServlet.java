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
import java.util.List;

import org.event.DBManager;
import org.event.models.*;
import jakarta.servlet.http.Part;

@WebServlet("/CreateEventServlet")
@MultipartConfig
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = (HttpSession) request.getSession();
        int organizerId = (int) session.getAttribute("organizer_id");
        
        Part part = request.getPart("image");
        String imagefile = part.getSubmittedFileName();
    String uploadpath = "E:/eclipse/event_organizer/src/main/webapp/images/"+imagefile;
        
    System.out.println(imagefile);
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDateString = request.getParameter("start_date");
        String endDateString = request.getParameter("end_date");
        String time = request.getParameter("time");
        String location = request.getParameter("location");
        float price = Float.parseFloat(request.getParameter("price"));
    
    try {
      FileOutputStream fos= new FileOutputStream(uploadpath);
      InputStream is = part.getInputStream();
      byte [] data = new byte[is.available()];
      is.read(data);
      fos.write(data);
        fos.close();
        System.out.println("succeess");
    }catch(Exception e)
    {
      e.printStackTrace();
    }// Parse the price from the request

        try (Connection conn = DBManager.getConnection()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date startDate =  sdf.parse(startDateString);
            java.util.Date endDate = sdf.parse(endDateString);
            String newImageUrl = imagefile;


            String sql = "INSERT INTO events (title, description, start_date, end_date, time, location, organizer_id, price,image_url) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, description);
                statement.setDate(3, new java.sql.Date(startDate.getTime()));
                statement.setDate(4, new java.sql.Date(endDate.getTime()));
                statement.setString(5, time);
                statement.setString(6, location);
                statement.setInt(7, organizerId);
                statement.setFloat(8, price);
                statement.setString(9,newImageUrl);

                int rowsAffected = statement.executeUpdate();

                if (rowsAffected > 0) {
                	 GetAllEvents getAllEventsServlet = new GetAllEvents();
                	List<Event> events = getAllEventsServlet.getAllEvents();
                    session.setAttribute("events", events);
                    session.setAttribute("message", "Event created successfully!");
                } else {
                    session.setAttribute("message", "Failed to create the event. Please try again.");
                }
                response.sendRedirect("createevent.jsp");
            }
        } catch (ParseException | SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "An error occurred. Please try again.");
            response.sendRedirect("createevent.jsp");
        }
    }
    


}