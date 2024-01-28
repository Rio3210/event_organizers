> Salah:
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="org.event.models.Event"%>
<%@ page import="org.event.servlets.OrderServlet"%>
<%@ page import="java.util.List"%>
<html>
<head>
<meta charset="UTF-8">
<title>Event Details</title>
<style>
.first {
  display: flex;
  width: 530px;
  height: 370px;
  margin: 0 auto;
  padding: 15px;
  margin-top: 20px;
  /* Center the container */
}

.img {
  flex-grow: 1;
  width:280px;
  
}


.img img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* Maintain aspect ratio */
}


.flex-grow-2 {
  flex-grow: 2;
  padding: 20px; /* Add padding for better spacing */
}

/* Add any additional styling as needed */
</style>
<link rel="icon" type="image/x-icon" href="images/logo.png">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.css">
<!-- Include any necessary CSS and JavaScript files -->
</head>
<body>
  <%@ include file="header.jsp"%>
  <section>
    <h1>Book now</h1>
  </section>
  <section class="mt-5">
    <%-- Retrieve the event object from the request --%>
    <%
    Event event = (Event) session.getAttribute("eventdetail");
    int userId = (int) session.getAttribute("organizer_id");
	
	OrderServlet ordercheck = new OrderServlet();
	Boolean check = ordercheck.CheckEventBoughtBefore(event.getEventId());
    %>

    <div class="event-details shadow bg-white rounded first">
      <div class="img flex-grow-2 ">
        <img
          src="images/<%=(event.getImageUrl() != null && !event.getImageUrl().isEmpty()) ? event.getImageUrl() : "test.png"%>"
          class="card-img-top image1" alt="Event Image">
      </div>
      <div class="flex-grow-2">
        <div class="event-content">
          <div class="clearfix mb-3">
            <span class="float-start badge rounded-pill bg-primary">price</span> <strong class="float-end price-hp px-1"><%=event.getPrice()%> Birr</strong>
          </div>
          <h5 class="card-title"><%=event.getTitle()%></h5>
          <p class="card-text">
            
            <%=event.getDescription()%></p>
          <!-- Display other event details as needed -->
          <p class="card-text">
          <strong>Location: </strong> <%=event.getLocation()%>
          </p>
          <p class="card-text">
          	<strong>Date: </strong> <%=event.getStartDate() %> to <%= event.getEndDate() %>
          </p>
          <div class="text-center my-4">
            <div class="text-center my-4">
              <form method="POST" action="https://api.chapa.co/v1/hosted/pay">
                <input type="hidden" name="public_key"
                  value="CHAPUBK_TEST-UhQEgTdhxjGoxukKIL0rPsK0ZAwtsOXm" />
                <%-- Generate a unique transaction reference using the current timestamp --%>
                <%
                String txRef = "negade-tx-" + System.currentTimeMillis();
                %>
                <input type="hidden" name="tx_ref" value="<%=txRef%>" /> <input
                  type="hidden" name="amount" value="<%=event.getPrice()%>" />
                <input type="hidden" name="currency" value="ETB" /> <input
                  type="hidden" name="email" value="abebech_bekele@gmail.com" />
                <input type="hidden" name="first_name" value="Bilen" /> <input
                  type="hidden" name="last_name" value="Gizachew" /> <input
                  type="hidden" name="title"
                  value="Payment for <%=event.getOrganizerId()%>" /> <input
                  type="hidden" name="description" value="I love online payments" />
                <input type="hidden" name="logo"
                  value="https://chapa.link/asset/images/chapa_swirl.svg" /> <input
                  type="hidden" name="callback_url"
                  value="https://webhook.site/077164d6-29cb-40df-ba29-8a00e59a7e60" />
                <%
                String returnUrl = "http://localhost:8088/event_organizer/OrderServlet?user_id=" + userId + "event_id="
                    + event.getEventId();
                %>
                <input type="hidden" name="return_url" value="<%=returnUrl%>" />
                <input type="hidden" name="meta[title]" value="test" />
                <%-- Conditionally show/hide Pay Now button --%>
                <% if (userId != event.getOrganizerId() && !check) { %>
                  <button type="submit" class="btn btn-primary">Pay Now</button>
                <% } %>
              </form>
            </div>
          </div>
        </div>
</div>
    </div>

  </section>

  <%@ include file="footer.jsp"%>

  <!-- Include any necessary JavaScript code -->

</body>
</html>
