<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Page Not Found - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <h1>404 - Page Not Found</h1>
        <p>The page you're looking for doesn't exist or has been moved.</p>
        <div class="error-image">
            <img src="${pageContext.request.contextPath}/images/404-error.png" alt="404 Error">
        </div>
        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home Page</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</div>
</body>
</html>