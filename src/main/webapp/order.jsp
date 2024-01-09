<%@ page import="org.event.models.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.event.DBManager" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
    .event-container {
        display: flex;
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

    .event-image {
        flex: 0 0 150px;
        margin-right: 20px;
    }

    .event-details {
        flex: 1;
    }

    .event-title {
        font-size: 18px;
        font-weight: bold;
    }

    .event-description {
        margin-top: 10px;
    }

    .event-price {
        margin-top: 10px;
        font-weight: bold;
    }
</style>
</head>
<body>
 <%@ include file="header.jsp" %>
 <section>
    <h1 class="text-center my-5 pt-5">My Orders</h1>
 </section>
    <% 
	    
	    
        
        // Fetch the list of events bought by the current user from the database
        List<Event> events = fetchUserEvents((int) session.getAttribute("organizer_id"));
        
        // Display the list of events
        if (events != null && !events.isEmpty()) {
            for (Event event : events) {
                %>
                <div class="event-container d-flex justify-content-center">
                    <div class="event-image">
                    	<!-- <img src="event.getImageURL() " alt="Event Image" height="100"> -->
                        <img src="images/test.png" alt="Event Image" height="100">
                    </div>
                    <div class="event-details">
                        <div class="event-title"><%= event.getTitle() %></div>
                        <div class="event-description"><%= event.getDescription() %></div>
                        <div class="event-price">Price: $<%= event.getPrice() %></div>
                        <div class="event-date">Date: <%= event.getStartDate() %> - <%= event.getEndDate() %></div>
                        <div class="event-time">Time: <%= event.getTime() %></div>
                        <div class="event-location">Location: <%= event.getLocation() %></div>
                        <!-- Add other event details here -->
                    </div>
                </div>
                <%
            }
        } else {
            out.println("<p>No events found.</p>");
        }
    %>
    
    <%-- Function to fetch the list of events bought by the current user --%>
    <%!
        private List<Event> fetchUserEvents(int userID) {
            List<Event> events = new ArrayList<>();
            
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            
            try {
                connection = DBManager.getConnection();

                // Prepare the SQL statement to fetch events bought by the current user
                String sql = "SELECT e.event_id, e.title, e.description, e.start_date, e.end_date, e.time, e.location, e.price " +
                             "FROM events e " +
                             "JOIN orders o ON o.event_id = e.event_id " +
                             "WHERE o.user_id = ?";
                statement = connection.prepareStatement(sql);

                // Set the parameter value
                statement.setInt(1, userID);

                // Execute the query
                resultSet = statement.executeQuery();

                // Process the result set
                while (resultSet.next()) {
                    Event event = new Event();
                    event.setEventId(resultSet.getInt("event_id"));
                    event.setTitle(resultSet.getString("title"));
                    event.setDescription(resultSet.getString("description"));
                    event.setStartDate(resultSet.getDate("start_date"));
                    event.setEndDate(resultSet.getDate("end_date"));
                    event.setTime(resultSet.getTime("time"));
                    event.setLocation(resultSet.getString("location"));
                    event.setPrice(resultSet.getFloat("price"));
                    events.add(event);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Close the result set, statement, and connection
                try {
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            
            return events;
        }
    %>
 
  <%@ include file="footer.jsp" %>
</body>
</html>