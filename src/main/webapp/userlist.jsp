<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.event.models.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>User List</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <h1 class="my-5 pt-5 text-center">User List</h1>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Email</th>
                </tr>
            </thead>
            
            <tbody>
                <% for (User user : (List<User>) request.getAttribute("attendees")) { %>
                    <tr>
                        <td><%= user.getUserId() %></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getEmail() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
    
    <script src="js/bootstrap.min.js"></script>
</body>
</html>