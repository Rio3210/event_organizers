	<%@ page import="jakarta.servlet.http.HttpSession"%>
	<%@ page import="java.io.IOException"%>
	<%@ page import="java.sql.SQLException"%>
	<%@ page import="java.sql.Connection"%>
	<%@ page import="java.sql.PreparedStatement"%>
	<%@ page import ="java.sql.ResultSet"%>


<%
    int organizerId = (int) session.getAttribute("organizer_id");
    String imageUrl = null; // Declare imageUrl outside the try-catch block

    Connection connection = null;
    try {
        connection = org.event.DBManager.getConnection();

        String query = "SELECT image_url FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, organizerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    imageUrl = rs.getString("image_url");
                    String profileImagePath = imageUrl;
                    System.out.println("User image fetched: " + imageUrl);
                } else {
                    System.out.println("No image found for the user");
                }
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
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>


	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<a class="navbar-brand" href="index.jsp"> <img
			src="images/logo.png" height="40" alt="Logo"> <!-- Replace with your logo -->
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-center"
			id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="index.jsp"
					style="color: rgba(0, 0, 0, 0.8);">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="createevent.jsp"
					style="color: rgba(0, 0, 0, 0.8);">Create Event</a></li>
				<li class="nav-item"><a class="nav-link"
					href="GetPersonalEvents" style="color: rgba(0, 0, 0, 0.8);">My
						Events</a></li>
			</ul>
		</div>
		<div class="navbar-nav ml-auto">
			<a class="nav-item nav-link" href="order.jsp"> <i
				class="fas fa-shopping-cart"></i> <!-- Font Awesome shopping cart icon -->
			</a> <a class="nav-item nav-link" href="profile.jsp"> <img
				src="images/<%=imageUrl %>" alt="Profile" height="30"
				class="rounded-circle"> <!-- Replace with profile image -->
			</a>
		</div>
	</nav>
</body>
</html>