<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header class="header">
    <div class="container">
        <div class="navbar">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">Vehicle Rental System</a>
            <button class="navbar-toggle" id="navbar-toggle">
                <i class="fas fa-bars"></i>
            </button>
            <ul class="navbar-nav" id="navbar-nav">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/auth/login" class="nav-link">Login</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/auth/register" class="nav-link">Register</a>
                </li>
            </ul>
        </div>
    </div>
</header>

<div class="container">
    <div class="login-container">
        <div class="card">
            <div class="card-body">
                <h2 class="text-center mb-4">Login</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth/login" method="post">
                    <div class="form-group">
                        <label for="username" class="required">Username</label>
                        <input type="text" id="username" name="username" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="password" class="required">Password</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </div>
                </form>

                <div class="form-footer">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register">Register</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-brand">
                <h3>Vehicle Rental System</h3>
                <p>Your trusted partner for vehicle rentals</p>
            </div>

            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/vehicles/catalog">Browse Vehicles</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth/register">Register</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth/login">Login</a></li>
                </ul>
            </div>

            <div class="footer-contact">
                <h4>Contact Us</h4>
                <p><i class="fas fa-envelope"></i> support@vehiclerental.com</p>
                <p><i class="fas fa-phone"></i> +1-234-567-8900</p>
                <p><i class="fas fa-map-marker-alt"></i> 123 Rental Street, City, Country</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2023 Vehicle Rental System. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    // Mobile navigation toggle
    document.getElementById('navbar-toggle').addEventListener('click', function() {
        document.getElementById('navbar-nav').classList.toggle('show');
    });
</script>
</body>
</html>