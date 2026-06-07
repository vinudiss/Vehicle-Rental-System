<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Access Denied - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<div class="error-container">
    <div class="error-content">
        <h1>403 - Access Denied</h1>
        <div class="error-icon">
            <i class="lock-icon">🔒</i>
        </div>
        <p>Sorry, you don't have permission to access this page.</p>
        <p class="error-details">The requested page requires higher privileges than you currently have.</p>

        <div class="error-actions">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home Page</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
        </div>
    </div>
</div>

<style>
    .error-container {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 80vh;
        padding: 20px;
    }

    .error-content {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 40px;
        text-align: center;
        max-width: 600px;
        width: 100%;
    }

    .error-icon {
        font-size: 64px;
        margin: 20px 0;
        color: #e74c3c; /* Red color for danger/error */
    }

    h1 {
        color: #e74c3c; /* Red color for danger/error */
        margin-bottom: 20px;
    }

    .error-details {
        color: #777;
        margin-bottom: 30px;
    }

    .error-actions {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 20px;
    }
</style>
</body>
</html>