<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.event.models.Event"%>
<%@ page import="java.util.List"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
    <link rel="icon" type="image/x-icon" href="images/logo.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Include any necessary CSS and JavaScript files -->
</head>
<body>
<%@ include file="header.jsp" %>
<section class="my-5">
    <%-- Retrieve the event object from the request --%>
    <% Event event = (Event) request.getAttribute("eventdetail"); %>

    <div class="event-details">
        <img src="images/test.png" class="event-image" alt="Event Image">
        <div class="event-content">
            <div class="clearfix mb-3">
                <span class="float-start badge rounded-pill bg-primary">ASUS Rog</span>
                <span class="float-end price-hp"><%= event.getPrice() %>&euro;</span>
            </div>
            <h5 class="card-title"><%= event.getTitle() %></h5>
            <p class="card-text">Description: <%= event.getDescription() %></p>
            <!-- Display other event details as needed -->
            <div class="text-center my-4">
                <form method="POST" action="https://api.chapa.co/v1/hosted/pay">
                    <input type="hidden" name="public_key" value="CHAPUBK_TEST-UhQEgTdhxjGoxukKIL0rPsK0ZAwtsOXm" />
                    <%-- Generate a unique transaction reference using the current timestamp --%>
                    <%
                        String txRef = "negade-tx-" + System.currentTimeMillis();
                    %>
                    <% 
            	    int userId = (int) session.getAttribute("organizer_id"); %>
                    <input type="hidden" name="tx_ref" value="<%= txRef %>" />
                    <input type="hidden" name="amount" value="<%= event.getPrice() %>" />
                    <input type="hidden" name="currency" value="ETB" />
                    <input type="hidden" name="email" value="abebech_bekele@gmail.com" />
                    <input type="hidden" name="first_name" value="Bilen" />
                    <input type="hidden" name="last_name" value="Gizachew" />
                    <input type="hidden" name="title" value="Payment for <%= event.getOrganizerId() %>" />
                    <input type="hidden" name="description" value="I love online payments" />
                    <input type="hidden" name="logo" value="https://chapa.link/asset/images/chapa_swirl.svg" />
                    <input type="hidden" name="callback_url" value="https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60" />
                   <% String returnUrl = "http://localhost:8088/event_organizer/OrderServlet?user_id=" + userId + "event_id=" + event.getEventId(); %>
                    <input type="hidden" name="return_url" value="<%=returnUrl %>" />
                    <input type="hidden" name="meta[title]" value="test" />
                    <button type="submit" class="btn btn-primary">Pay Now</button>
                </form>
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

<!-- Include any necessary JavaScript code -->

</body>
</html>