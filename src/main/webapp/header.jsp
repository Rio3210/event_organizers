<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <a class="navbar-brand" href="index.jsp">
        <img src="images/logo.png" height="40" alt="Logo"> <!-- Replace with your logo -->
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp" style="color: rgba(0, 0, 0,0.8);">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="createevent.jsp" style="color: rgba(0, 0, 0,0.8);">Create Event</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="GetPersonalEvents" style="color: rgba(0, 0, 0,0.8);">My Events</a>
            </li>
        </ul>
    </div>
    <div class="navbar-nav ml-auto">
        <a class="nav-item nav-link" href="order.jsp">
            <i class="fas fa-shopping-cart"></i> <!-- Font Awesome shopping cart icon -->
        </a>
        <a class="nav-item nav-link" href="profile.jsp">
            <img src="images/temp_prof.jpg" alt="Profile" height="30" class="rounded-circle"> <!-- Replace with profile image -->
        </a>
    </div>
</nav>
</body>
</html>