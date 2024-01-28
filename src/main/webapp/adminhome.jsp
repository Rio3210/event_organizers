<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.event.models.News" %> 
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
     <link rel="stylesheet" href="css/bootstrap.css">
    
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
        h3 {
            color: #007bff;
           =
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
        .cont{
        	height:100vh;
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
                    <form action="adminlanding" class="nav-link" method="get">
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
                        <input type="submit" value="Create Post" class="btn btn-info">
                    </form>
                </li>
            </div>
        </div>
    </nav>
</header>

    </section>

    <section>
        <section class="cont w-100 mx-auto">
    <div class="container">
        <h3 class="mt-4">Dashboard</h3>
        <div class="d-flex flex-wrap">
            <div class="card">
                <div class="card-header">
                    Total Users
                </div>
                <div class="card-body text-center font-weight-bold">
                    <%= request.getAttribute("totalUsers") %>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    Total Events
                </div>
                <div class="card-body text-center font-weight-bold">
                    <%= request.getAttribute("totalEvents") %>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    Total Orders
                </div>
                <div class="card-body text-center font-weight-bold">
                    <%= request.getAttribute("totalOrders") %> 
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    Total Money Transactions
                </div>
                <div class="card-body text-center font-weight-bold">
                    <%= request.getAttribute("totalRevenue") %> Birr
                </div>
            </div>
        </div>
    </div>
</section>
    </section>

    <%@ include file="footer.jsp"%>
</body>

</html>
