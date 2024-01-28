<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
     <link rel="stylesheet" href="css/bootstrap.css">
    
    <style>
      
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
    </style>
</head>

<title>Admin page</title>

<body>
    <section class="bgcolor-ed">
    		
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
	<div class="container mt-5">
			 <%
		    String message = (String) session.getAttribute("statusm");
		    if (message != null && !message.isEmpty()) {
		    %>
		    <div class="alert alert-primary text-center" role="alert">
		      <%=message%>
		    </div>
		
		    <%
		    }
		    %>
		    <%
		    session.removeAttribute("statusm");
		    %>
        <div class="news-form">
            <h2 class="text-center mb-4">Create Post</h2>
            <form action="adminnews" method="post">
                <div class="form-group">
                    <label for="newsTitle">Title:</label>
                    <input type="text" class="form-control" name="title" placeholder="Enter news title" required>
                </div>
                <div class="form-group">
                    <label for="newsDescription">Description:</label>
                    <textarea class="form-control" name="description" rows="5"
                        placeholder="Enter news description" required></textarea>
                </div>
                <button type="submit" class="btn btn-add-news btn-block btn-white">Create Post</button>
            </form>
        </div>
    </div>
	</section>    
  <%@ include file="footer.jsp"%>

</body>

</html>

