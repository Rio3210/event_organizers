
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.event.models.User" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
     <link rel="stylesheet" href="css/bootstrap.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
   
	 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

        th, td {
            text-align: center;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #dee2e6;
        }

        th {
            background-color: #007bff;
            color: #fff;
        }

        h3 {
            color: #007bff;
            margin-top: 20px;
        }
        .cont{
        	height:100vh;
        }
    </style>
</head>

<title>users</title>

<body>
    <section>
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

    <section class="cont">
        <div class="container">
            <h3>Users</h3>
            <table class="table table-bordered">
                <thead class="thead-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
			    <% List<User> users = (List<User>) request.getAttribute("users");
			    for (User user : users) { %>
			    <tr>
			        <td><%= user.getUserId() %></td>
			        <td><%= user.getUsername() %></td>
			        <td><%= user.getEmail() %></td>
			        <td>
			            <a href="#" class="delete-icon" data-toggle="modal" data-target="#confirmDeleteModal">
			                <i class="fas fa-trash-alt"></i>
			            </a>
			        </td>
    </tr>
    <% } %>
</tbody>
            </table>
        </div>
    </section>
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmDeleteModalLabel">Delete Account</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this user?</p>
                <form method="post" action="userdelete">
                    <input type="hidden" name="userId" value="">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    <%@ include file="footer.jsp"%>
    <script src="js/bootstrap.js"></script>
    <script>
    $(document).ready(function() {
        $('.delete-icon').click(function() {
            var userId = $(this).closest('tr').find('td:first').text();
            $('#confirmDeleteModal input[name="userId"]').val(userId);
        });
    });
</script>
</body>

</html>

