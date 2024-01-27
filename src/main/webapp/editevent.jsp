<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="org.event.models.Event"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        .custom-card {
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>
    <section class="my-5 pt-5">
    <%
	    String message = (String) session.getAttribute("message");
	    if (message != null && !message.isEmpty()) {
	    %>
	    <div class="alert alert-primary text-center" role="alert">
	      <%=message%>
	    </div>
	
	    <%
	    }
	    %>
	    <%
	    session.removeAttribute("message");
	    %>
    <% Event event = (Event) request.getAttribute("editevent"); %>
        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card custom-card">
                        <h2 class="card-title text-center mb-4">Edit Event</h2>
                        <form action="UpdateEventServlet" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="title" class="form-label">Title:</label>
                                <input type="text" name="title" id="title" class="form-control" value="<%= (event != null) ? event.getTitle() : "" %>" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">Description:</label>
                                <textarea name="description" id="description" class="form-control"><%= (event != null) ? event.getDescription() : "" %></textarea>
                            </div>
                            <div class="mb-3">
                                <p>Choose an image:</p>
                                <label for="image" class="form-label"></label>
                                <input type="file" name="image">
                                <!-- Add any necessary logic for handling image updates -->
                            </div>
                            
                            <div class="mb-3">
                                <label for="start_date" class="form-label">Start Date:</label> 
                                <input type="date" name="start_date" id="start_date"
                                    class="form-control" value="<%= (event != null && event.getStartDate() != null) ? event.getStartDate() : "" %>">
                            </div>
                            <div class="mb-3">
                                <label for="end_date" class="form-label">End Date:</label> 
                                <input type="date" name="end_date" id="end_date" class="form-control"
                                    value="<%= (event != null && event.getEndDate() != null) ? event.getEndDate() : "" %>">
                            </div>
                            <div class="mb-3">
                                <label for="time" class="form-label">Time:</label> 
                                <input type="text" name="time" id="time" class="form-control" 
                                    value="<%= (event != null) ? event.getTime() : "" %>">
                            </div>
                            <div class="mb-3">
                                <label for="location" class="form-label">Location:</label> 
                                <input type="text" name="location" id="location" class="form-control"
                                    value="<%= (event != null) ? event.getLocation() : "" %>">
                            </div>
                            <div class="mb-3">
                                <label for="price" class="form-label">Price:</label> 
                                <input type="number" name="price" id="price" class="form-control"
                                    value="<%= (event != null) ? event.getPrice() : "" %>">
                            </div>
                            <input type="hidden" name="eventId" value="<%= (event != null) ? event.getEventId() : "" %>">
                            <input type="submit" class="btn btn-primary" value="Update Event">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp"%>
</body>
</html>
