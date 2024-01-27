<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.event.models.Event"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Events</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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

        <section>
            <div class="row my-5">
                <% 
                    List<Event> events = (List<Event>) request.getAttribute("event");
                    if (events != null && !events.isEmpty()) {
                        for (Event event : events) {
                %>
                <div class="col-md-4 mt-2">
                    <div class="card  shadow-sm">
                       <img src="images/<%= (event.getImageUrl() != null && !event.getImageUrl().isEmpty()) ? event.getImageUrl() : "test.png" %>" class="card-img-top" alt="Event Image">
                        <div class="card-body">
                            <div class="clearfix mb-3">
                                <span class="float-start badge rounded-pill bg-primary">price</span>
                                <span class="float-end price-hp"><%=event.getPrice() %></span>
                            </div>
                            <h5 class="card-title"><%= event.getTitle() %></h5>
                            <p class="card-text">Description: <%= event.getDescription() %></p>
                            <div class="text-center my-4">
                                <form action="EventUpdateHelper" method="post" class="d-inline mx-auto">
                                    <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                    <button type="submit" class="btn btn-success w-100 rounded">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                </form>
                            </div>
                            <div class="text-center my-4">
                                <form id="deleteForm_<%= event.getEventId() %>" action="DeleteEventServlet" method="post" class="d-inline mx-auto">
                                    <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                    <button type="button" class="btn btn-danger w-100 rounded" onclick="confirmDelete('<%= event.getEventId() %>')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                            <div class="text-center my-4">
                                <form action="UserListServlet" method="post" class="d-inline mx-auto">
                                    <input type="hidden" name="eventId" value="<%= event.getEventId() %>">
                                    <button type="submit" class="btn btn-info w-100 rounded">
                                        <i class="fas fa-users"></i> View Attendees
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <p>No events found.</p>
                <% } %>
            </div>
        </section>
    </div>

    <%@ include file="footer.jsp" %>
    <script src="js/bootstrap.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script type="text/javascript">
        function confirmDelete(eventId) {
            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this event!",
                icon: "warning",
                buttons: {
                    cancel: "Cancel",
                    confirm: {
                        text: "Delete",
                        value: true,
                        visible: true,
                        className: "btn-danger",
                    },
                },
            }).then((willDelete) => {
                if (willDelete) {
                    // If the user clicks "Delete"
                    document.getElementById("deleteForm_" + eventId).submit();
                } else {
                    // If the user clicks "Cancel"
                    swal("The event is safe!", {
                        icon: "info",
                    });
                }
            });
        }
    </script>
</body>
</html>