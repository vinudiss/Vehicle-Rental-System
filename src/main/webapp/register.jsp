<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Vehicle Rental System</title>
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
    <div class="register-container">
        <div class="card">
            <div class="card-body">
                <h2 class="text-center mb-4">Create an Account</h2>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth/register" method="post" id="registerForm">
                    <div class="form-group">
                        <label for="username" class="required">Username</label>
                        <input type="text" id="username" name="username" class="form-control" value="${username}" required>
                        <span class="form-hint">4-20 characters, letters, numbers, underscores, or hyphens only</span>
                    </div>

                    <div class="form-group">
                        <label for="password" class="required">Password</label>
                        <input type="password" id="password" name="password" class="form-control" required>
                        <span class="form-hint">At least 8 characters with 1 uppercase, 1 lowercase, and 1 digit</span>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword" class="required">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="fullName" class="required">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" value="${fullName}" required>
                    </div>

                    <div class="form-group">
                        <label for="email" class="required">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="${email}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone" class="required">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" value="${phone}" required>
                        <span class="form-hint">Enter a valid phone number</span>
                    </div>

                    <div class="form-group">
                        <label for="driverLicense" class="required">Driver License Number</label>
                        <input type="text" id="driverLicense" name="driverLicense" class="form-control" value="${driverLicense}" required>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn btn-primary w-100">Register</button>
                    </div>
                </form>

                <div class="form-footer">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login</a></p>
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

    // Form validation
    document.getElementById('registerForm').addEventListener('submit', function(event) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            event.preventDefault();
            alert('Passwords do not match');
        }

        const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$/;
        if (!passwordPattern.test(password)) {
            event.preventDefault();
            alert('Password must be at least 8 characters with 1 uppercase, 1 lowercase, and 1 digit');
        }

        const usernamePattern = /^[a-zA-Z0-9_-]{4,20}$/;
        const username = document.getElementById('username').value;
        if (!usernamePattern.test(username)) {
            event.preventDefault();
            alert('Username must be 4-20 characters and contain only letters, numbers, underscores, or hyphens');
        }
    });
</script>
</body>
</html>