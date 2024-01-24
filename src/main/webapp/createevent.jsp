<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta charset="UTF-8">
<title>Create Event</title>
<link rel="stylesheet" href="css/bootstrap.css">
<style>
.custom-card {
  box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
  /* Adjust the shadow according to your preference */
  padding: 20px; /* Add padding to the card */
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
    <div class="alert alert-primary" role="alert">
      <%=message%>
    </div>

    <%
    }
    %>
    <%
    session.removeAttribute("message");
    %>

    <div class="container my-5">
      <div class="row justify-content-center">
        <div class="col-lg-6">
          <div class="card custom-card">
            <h2 class="card-title text-center mb-4">Create Event</h2>
            <form action="CreateEventServlet" method="post" enctype="multipart/form-data">
              <div class="mb-3">
                <label for="title" class="form-label">Title:</label> <input
                  type="text" name="title" id="title" class="form-control"
                  required>
              </div>
              <div class="mb-3">
                <label for="description" class="form-label">Description:</label>
                <textarea name="description" id="description"
                  class="form-control"></textarea>
              </div>
              <div class="mb-3">
                <p>Choose an image:</p>
                
                <label for="start_date" class="form-label">
                </label> <input type="file" name="image" required> 
                
              </div>
              <div class="mb-3">
                <label for="start_date" class="form-label">Start Date:</label> <input
                  type="date" name="start_date" id="start_date"
                  class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="end_date" class="form-label">End Date:</label> <input
                  type="date" name="end_date" id="end_date" class="form-control"
                  required>
              </div>
              <div class="mb-3">
                <label for="time" class="form-label">Time:</label> <input
                  type="text" name="time" id="time" class="form-control" required>
              </div>
              <div class="mb-3">
                <label for="location" class="form-label">Location:</label> <input
                  type="text" name="location" id="location" class="form-control"
                  required>
              </div>
              <div class="mb-3">
                <label for="price" class="form-label">Price:</label> <input
                  type="number" name="price" id="price" class="form-control"
                  required>
              </div>
              <button type="submit" class="btn btn-primary">Create
                Event</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>

  <%@ include file="footer.jsp"%>
</body>
</html>