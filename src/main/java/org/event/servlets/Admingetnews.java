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
import jakarta.servlet.http.HttpSession;
import org.event.DBManager;
import org.event.models.News;

/**
 * Servlet implementation class Admingetnews
 */
@WebServlet("/admingetnews")
public class Admingetnews extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admingetnews() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		List<News> news=fetchNewsArticles();
		request.setAttribute("news", news);
		if (session.getAttribute("role").equals("admin")) {
		request.getRequestDispatcher("Adminlandingpage.jsp").forward(request, response);
	} else {
		request.getRequestDispatcher("news.jsp").forward(request, response);
	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public List<News> fetchNewsArticles() {
	    List<News> news = new ArrayList<>();

	    try {
	        Connection connection = DBManager.getConnection();
	        PreparedStatement statement = connection.prepareStatement("SELECT * FROM news ORDER BY news_id DESC");
	        ResultSet resultSet = statement.executeQuery();

	        while (resultSet.next()) {
	            News news1 = new News();
	            news1.setNewsId(resultSet.getInt("news_id"));
	            news1.setTitle(resultSet.getString("title"));
	            news1.setDescription(resultSet.getString("description"));
	            news.add(news1);
	        }

	        // Close the resources
	        resultSet.close();
	        statement.close();
	        connection.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	        // Handle the exception appropriately, such as logging the error or displaying a user-friendly error message
	    }

	    return news;
	}
}
