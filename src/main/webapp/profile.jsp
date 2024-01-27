<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%
int organizerId = (int) session.getAttribute("organizer_id");
String imageUrl = null;
String firstName = null;
String lastName = null;
String username = null;
String email = null;

Connection connection = null;
try {
	connection = org.event.DBManager.getConnection();

	String query = "SELECT firstname, lastname, username, email, image_url FROM users WHERE user_id = ?";
	try (PreparedStatement stmt = connection.prepareStatement(query)) {
		stmt.setInt(1, organizerId);

		try (ResultSet rs = stmt.executeQuery()) {
	if (rs.next()) {
		firstName = rs.getString("firstname");
		lastName = rs.getString("lastname");
		username = rs.getString("username");
		email = rs.getString("email");
		imageUrl = rs.getString("image_url");

		//String profileImagePath = imageUrl;
		session.setAttribute("image_url",imageUrl);

		
	} else {
		System.out.println("No user found with the given ID");
	}
		}
	}
} catch (Exception e) {
	System.out.println(e);
} finally {
	if (connection != null) {
		try {
	connection.close();
		} catch (Exception e) {
	System.out.println(e);
		}
	}
}
%>



<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
	document.getElementById('confirmDelete').addEventListener('click',
			function() {
				alert('Account deleted successfully!');
			});
</script>


<style>
body {
	background: #f7f7ff;
	margin-top: 20px;
}

.btnbtn {
	width: 300px;
}

.btnbtn1 {
	margin-right: 10px
}

.profile-card {
	background: #fff;
	border-radius: .25rem;
	box-shadow: 0 2px 6px 0 rgb(218 218 253/ 65%), 0 2px 6px 0
		rgb(206 206 238/ 54%);
	padding: 20px;
	max-width: 800px;
	margin: 0 auto;
}

.progress {
	height: 5px !important;
}

.profile-container {
	max-width: 600px;
	margin: 50px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.change-password-container {
	text-align: right;
	margin-bottom: 20px;
}

.section-container {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-top: 60px
}
</style>

	<script>
        function logout() {
            // Assuming your logout servlet is mapped to "LogoutServlet"
            window.location.href = "logout";
        }
    </script>

</head>
<%@include file="header.jsp" %>
<body>
<h2 class="mt-5 text-center pt-3">Profile Settings</h2>
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
	<section class="mt-4">
		<div class="container">

			<div class="profile-card">

				<div class="row">

					<div class="col-md-4">

						<div class="d-flex flex-column align-items-center text-center">

							<img src="images/<%=imageUrl%>?t=<%=System.currentTimeMillis()%>" alt="ProfilePic"
    class="rounded-circle" width="200" height="200">

							<div class="mt-3">
								<h4><%=username%></h4>
								<p class="text-muted font-size-sm">Addis Ababa, Ethiopia</p>

							</div>

						</div>

						<hr class="my-4">

						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<h6 class="mb-0">full name</h6> <span class="text-secondary">
									<%=firstName%> <%=lastName%></span>
							</li>
							<li class="list-group-item">
								<h6 class="mb-0">email</h6> <span class="text-secondary">
									<%=email%></span>
							</li>
						</ul>

					</div>

					<div class="col-md-8">
						<h3 class="text-center mt-3 mb-4"></h3>

						<form method="post" action="userprofile">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="firstName">New First Name</label> <input
										type="text" class="form-control" name="firstName"
										placeholder="First Name"
										value="<%=firstName%>">
								</div>
								<div class="form-group col-md-6">
									<label for="lastName">New Last Name</label> <input type="text"
										class="form-control" name="lastName" placeholder="Last Name"
										value="<%=lastName%>">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="phone">New Username</label> 
									<input type="tel" class="form-control" name="username" placeholder="Phone"
										value="<%=username%>">
								</div>
							</div>
							<button type="submit" class="btn btn-info">Save Changes</button>
							<button type="reset" class="btn btn-info">Cancel</button>
						</form>


						<section class="section-container">

							<div class="form-group">
								  <form method="post" action="ImageUploadServlet" enctype="multipart/form-data">
								    <label for="image">Choose an image:</label>
								    <input type="file" name="image" required> <br>
								    <input type="submit" class="mt-3" value="Upload Image">
								    
								  </form>
								</div>


							<div
								class="d-flex justify-content-end align-items-center mt-1 mr-1 w-50 btnbtn">
								<button type="button" class="btn btn-info mr-1 "
									data-toggle="modal" data-target="#changePasswordModal">
									Change Password</button>
							</div>

						</section>
						<div
							class="d-flex justify-content-end align-items-center mt-1 mr-2">
							<button type="button" class="btn btn-danger  pr-4"
								data-toggle="modal" data-target="#deleteAccountModal">Delete
								Account</button>
						</div>

						<div class="d-flex justify-content-end mt-3">
					        <button type="button" class="btn btn-danger" onclick="logout()">Logout</button>
					    </div>

					</div>

				</div>

			</div>

		</div>
		
		<div class="modal" id="changePasswordModal" tabindex="-1"
			role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Change Password</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- Password change form -->
						<form method="post" action="changepasswordservlet">
							<div class="form-group">
								<label for="newPassword">New Password</label> <input
									type="password" class="form-control" name="newPassword"
									placeholder="Enter new password">
							</div>
							<div class="form-group">
								<label for="confirmPassword">Confirm New Password</label> <input
									type="password" class="form-control" name="confirmPassword"
									placeholder="Confirm new password">
							</div>
							<button type="submit" class="btn btn-info">Change
								Password</button>

						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
					</div>


				</div>
			</div>
		</div>
		<div class="modal" id="deleteAccountModal" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">Delete Account</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete your account?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Cancel</button>
						<button type="button" class="btn btn-danger" id="confirmDelete">Delete</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	 <%@ include file="footer.jsp" %>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (status == "failed") {
			swal("Sorry", "Email or password incorrecy", "error");
		}
		if (status == "missmatch") {
			swal("Sorry", "confirmed password doesn't match", "error");
		}
		if (status == "invalid") {
			swal("Sorry", "please provide all the fields", "error");
		}
		if (status == "resetSuccess") {
			swal("Congrats", "Password changed successfully", "success");
		}
	</script>
	<script>
  function refreshPage() {
    setTimeout(function() {
      location.reload();
    }, 7000); }
</script>
</body>
</html>
