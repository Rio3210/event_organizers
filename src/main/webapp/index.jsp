<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="org.event.models.Event"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Event Organizer</title>
  <link rel="icon" type="image/x-icon" href="images/logo.png">
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="css/bootstrap.css">
  <style>
    /* Custom CSS for changing link colors */
    .nav-link {
      font-size: 16px;
    }
    .card img{
      height: 160px;
    }
    .description {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
  }

  .description-short {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 100%;
  }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>
  
  <!-- hero section put and image and a text ("Host, Connect, Celebrate: Your Events, Our Platform!(with big font)
  Book and learn helpful tips from 3,168+ mentors in world-class companies with our global community(under the above with small font))" -->
  
  <section class="hero-section my-5">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-6">
          <img src="images/hero.png" alt="Hero Image" class="img-fluid rounded" style="max-width: 100%; height: auto; max-height: 80vh;">
        </div>
        <div class="col-md-6">
          <div class="text-center text-md-left">
            <h1 class="mt-4">Host, Connect, Celebrate: Your Events, Our Platform!</h1>
            <p class="lead">Book and learn helpful tips from 3,168+ mentors in world-class companies with our global community.</p>
            <a href="#exploremore" class="btn btn-primary">Explore More</a>
          </div>
        </div>
      </div>
    </div>
  </section>
  
  <section class="event-section my-5" id="exploremore">
    <div class="container">
      <h1 class="text-center mb-4">Conquer your next event</h1>
      <div class="row mb-4">
        <div class="col-md-6 mx-auto">
          <form id="searchForm">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Search for events" name="search" id="searchInput">
              <button type="submit" class="btn btn-primary mx-3">Search</button>
            </div>
          </form>
        </div>
      </div>
      <!-- Event cards -->
      <div class="row" id="eventCards">
  <% 
    List<Event> events = (List<Event>) session.getAttribute("events");
    if (events != null) {
      for (Event event : events) {
  %>
    <div class="col-md-4 event-card">
      <div class="card h-100 shadow-sm mt-5" style="max-height: 350px;">
        <img src="images/<%= (event.getImageUrl() != null && !event.getImageUrl().isEmpty()) ? event.getImageUrl() : "test.png" %>" class="card-img-top" alt="Event Image">

        <div class="card-body">
          <div class="clearfix mb-3">
            <span class="float-start badge rounded-pill bg-primary"><%= event.getPrice() %>Birr</span>
            <span class="float-end price-hp"><%= event.getStartDate() %> - <%= event.getEndDate() %></span>
          </div>
          <h5 class="card-title"><%= event.getTitle() %></h5>
          <p class="card-text description"><%= event.getDescription() %></p>
          <p class="card-text description-short d-none"></p> <!-- Hidden shortened description -->

          <div class="text-center my-4">
            <form action="EventDetailServlet" method="post" class="d-inline mx-auto">
              <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
              <button type="submit" class="btn btn-primary">Book Now</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  <%
      }
    }
  %>
</div>
    </div>
  </section>

  <%@ include file="footer.jsp" %>
  <script src="js/bootstrap.js"></script>
  <script>
    // Client-side search functionality
    const searchForm = document.getElementById('searchForm');
    const searchInput= document.getElementById('searchInput');
    const eventCards = document.getElementsByClassName('event-card');

    searchForm.addEventListener('submit', function(event) {
      event.preventDefault();
      const searchValue = searchInput.value.toLowerCase();

      for (let i = 0; i < eventCards.length; i++) {
        const cardTitle = eventCards[i].querySelector('.card-title').textContent.toLowerCase();
        const cardDescription = eventCards[i].querySelector('.card-text').textContent.toLowerCase();

        if (cardTitle.includes(searchValue) || cardDescription.includes(searchValue)) {
          eventCards[i].style.display = 'block';
        } else {
          eventCards[i].style.display = 'none';
        }
      }
    });
  </script>
</body>
</html>