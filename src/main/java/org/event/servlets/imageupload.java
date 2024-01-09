package org.event.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.event.DBManager;



@WebServlet("/ImageUploadServlet")
@MultipartConfig
public class imageupload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public imageupload() {
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
		Part part = request.getPart("image");
		String imagefile = part.getSubmittedFileName();
		String uploadpath = "C:/Users/TOSHIBA/Desktop/event/event_organizers/src/main/webapp/images/"+imagefile;
		System.out.println(uploadpath);
		
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
		}
		
		Connection connection = null;
        try {
            connection = DBManager.getConnection();
            
            HttpSession session = request.getSession();
    		int organizerId = (int) session.getAttribute("organizer_id");

            String newImageUrl = imagefile;
            int userId = organizerId;

            String query = "UPDATE users SET image_url = ? WHERE user_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setString(1, newImageUrl);
                stmt.setInt(2, userId);
                
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    System.out.println("Image URL updated successfully for user with user_id: " + userId);
                    response.sendRedirect("profile.jsp");
                } else {
                    System.out.println("No user found with ID: " + userId);
                }
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
