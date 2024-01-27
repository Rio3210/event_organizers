<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.event.models.News" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/x-icon" href="images/logo.png">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.css">
<meta charset="ISO-8859-1">
<title>EventOrg News</title>
<style>
    .news-container {
        display: flex;
        flex-direction: column; /* Updated */
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
        padding: 20px;
        border-radius: 5px;
        width: 80%;
        margin-left: auto;
        margin-right: auto;
    }

    .news-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 10px; /* Added */
    }

    .news-description {
        font-size: 14px; /* Updated */
    }
</style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <section class="my-5 py-5">
    <% 
        // Retrieve the news articles from the request attribute set in the servlet
        List<News> newsArticles = (List<News>) request.getAttribute("news");
        
        // Display the list of news articles
        if (newsArticles != null && !newsArticles.isEmpty()) {
            for (News article : newsArticles) {
                %>
                <div class="news-container">
                    <div class="news-title"><%= article.getTitle() %></div>
                    <div class="news-description"><%= article.getDescription() %></div>
                </div>
                <%
            }
        } else {
            out.println("<p>No news articles found.</p>");
        }
    %>
    </section>
    <%@ include file="footer.jsp" %>
</body>
</html>