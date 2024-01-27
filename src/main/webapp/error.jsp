<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Add any other CSS files or stylesheets here -->
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #f8f9fa;
        }

        .error-container {
            max-width: 400px;
            padding: 20px;
            border: 1px solid #d6d8db;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .error-title {
            font-size: 24px;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 16px;
            color: #212529;
            margin-bottom: 20px;
        }

        .btn-back {
            background-color: #007bff;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-title">Error</div>
        <div class="error-message">${errorMessage}</div>
        <a href="${backUrl}" class="btn btn-back">Go Back</a>
    </div>
</body>
</html>