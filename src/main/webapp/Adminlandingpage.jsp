<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.event.models.News" %> 
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>

        .bgcolor-ed {
            background-color: #007bff;
            color: #fff;
            padding: 10px 0;
        }

        .news-form {
            max-width: 600px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        .btn-add-news {
            background-color: #007bff;
            color: #fff;
        }

        .card {
            width: 18rem;
            margin: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #17a2b8; /* Info color */
            color: #fff;
            text-align: center;
            font-weight: bold;
        }

        .card-body {
            padding: 20px;
        }
    </style>
</head>

<title>Landing Page</title>

<body>
    <section >
       <header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light ">
        <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" height="40" alt="Logo">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <ul class="navbar-nav">
                <!-- Add the Home button -->
                 <li class="nav-item mr-3 ml-5">
                    <form action="admingetnews" class="nav-link" method="get">
                        <input type="submit" value="Home" class="btn btn-info">
                    </form>
                </li>
            </ul>
            <div class="navbar-nav ml-auto d-flex">
                <li class="nav-item mr-3">
                    <form action="adminuserget" class="nav-link" method="get">
                        <input type="submit" value="User list" class="btn btn-info">
                    </form>
                </li>
                <li class="nav-item mr-3">
                    <form action="Admineventlist" class="nav-link" method="get">
                        <input type="submit" value="Event list" class="btn btn-info">
                    </form>
                </li>
                <li class="nav-item">
                    <form action="Adminpage.jsp" class="nav-link" method="get">
                        <input type="submit" value="News" class="btn btn-info">
                    </form>
                </li>
            </div>
        </div>
    </nav>
</header>

    </section>

    <section>
        <div class="container">
            <h3 class="mt-4">News List</h3>
            <div class="d-flex flex-wrap">
                <%
                    List<News> news = (List<News>) request.getAttribute("news");
                    for (News n : news) {
                %>
                <div class="card">
                    <div class="card-header">
                        <%= n.getTitle() %>
                    </div>
                    <div class="card-body">
                        <p><%= n.getDescription() %></p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp"%>
</body>

</html>
