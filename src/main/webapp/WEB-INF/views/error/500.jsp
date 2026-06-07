<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Server Error - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <h1>500 - Server Error</h1>
        <p>Sorry, something went wrong on our end. Please try again later.</p>
        <div class="error-image">
            <img src="${pageContext.request.contextPath}/images/500-error.png" alt="500 Error">
        </div>
        <div class="error-message">
            <% if (exception != null) { %>
            <p>Error: <%= exception.getMessage() %></p>
            <% } %>
        </div>
        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home Page</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</div>
</body>
</html>