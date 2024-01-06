<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.event.models.Event"%>
<%@ page import="java.util.List"%>
<%@ page import="org.event.models.User"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Events</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Add any other CSS files or stylesheets here -->
    <style>
    	.card img {
  	    height: 160px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1>My Events</h1>
    
    <%-- Display the events here --%>
    <section>
        <div class="row my-5">
            <% 
                List<Event> events = (List<Event>) request.getAttribute("event");
                if (events != null) {
                    for (Event event : events) {
            %>
            <div class="col-md-4 mt-2">
                <div class="card  shadow-sm">
                    <img src="images/test.png" class="card-img-top" alt="Event Image">
                    <div class="card-body">
                        <div class="clearfix mb-3">
                            <span class="float-start badge rounded-pill bg-primary">ASUS Rog</span>
                            <span class="float-end price-hp">12354.00&euro;</span>
                        </div>
                        <h5 class="card-title"><%= event.getTitle() %></h5>
                        <p class="card-text">Description: <%= event.getDescription() %></p>
                        <!-- Display other event details as needed -->
                        <div class="text-center my-4">
                            <form action="EventDetailServlet" method="post" class="d-inline mx-auto">
                                <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                <button type="submit" class="btn btn-success w-100">Edit</button>
                            </form>
                        </div>
                        <div class="text-center my-4">
                            <form action="EventDetailServlet" method="post" class="d-inline mx-auto">
                                <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                <button type="submit" class="btn btn-danger w-100">Delete</button>
                            </form>
                        </div>
                        <div class="text-center my-4">
                            <form action="UserListServlet" method="post" class="d-inline mx-auto">
                                <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                <button type="submit" class="btn btn-info w-100">View Attendees</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <%  } else { %>
            <p>No events found.</p>
            <% } %>
        </div>
    </section>
</div>

<%@ include file="footer.jsp" %>
<script src="js/bootstrap.js"></script>
<!-- Add any other JavaScript files or scripts here -->
</body>
</html>