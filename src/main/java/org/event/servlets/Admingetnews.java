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
		try {
			Connection connection = DBManager.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM news");
			ResultSet resultSet = statement.executeQuery();
			List<News> news = new ArrayList<>();
			while (resultSet.next()) {
				News news1 = new News();
				news1.setNewsId(resultSet.getInt("news_id"));
				news1.setTitle(resultSet.getString("title"));
				news1.setDescription(resultSet.getString("description"));
				news.add(news1);
			}
			request.setAttribute("news", news);
			request.getRequestDispatcher("Adminlandingpage.jsp").forward(request, response);

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
