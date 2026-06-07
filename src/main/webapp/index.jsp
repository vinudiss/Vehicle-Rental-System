<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Vehicle Rental System</title>
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
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Not logged in -->
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/auth/login" class="nav-link">Login</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/auth/register" class="nav-link">Register</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- User is logged in -->
                        <c:if test="${sessionScope.userType == 'ADMIN'}">
                            <!-- Admin navigation -->
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/users/list" class="nav-link">Users</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/vehicles/list" class="nav-link">Vehicles</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/list" class="nav-link">Rentals</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/report" class="nav-link">Reports</a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.userType == 'CUSTOMER'}">
                            <!-- Customer navigation -->
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/customer/dashboard" class="nav-link">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="nav-link">Vehicles</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/list" class="nav-link">My Rentals</a>
                            </li>
                        </c:if>

                        <!-- User menu for all logged-in users -->
                        <li class="nav-item user-menu">
                            <a href="#" class="nav-link">${sessionScope.username} <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown-menu">
                                <c:if test="${sessionScope.userType == 'CUSTOMER'}">
                                    <a href="${pageContext.request.contextPath}/customer/profile" class="dropdown-item">My Profile</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item">Logout</a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</header>

<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">Rent the Perfect Vehicle for Your Journey</h1>
            <p class="hero-text">Wide selection of cars, motorcycles, and trucks at competitive prices</p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary btn-lg">Sign Up Now</a>
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline-primary btn-lg">Login</a>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <section class="features-section">
        <h2 class="text-center">Why Choose Our Vehicle Rental System</h2>
        <div class="features">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-car"></i>
                </div>
                <h3>Wide Selection</h3>
                <p>Choose from our extensive fleet of cars, motorcycles, and trucks to suit your needs.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h3>Easy Booking</h3>
                <p>Our streamlined booking process makes it quick and easy to rent your preferred vehicle.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-calendar"></i>
                </div>
                <h3>Flexible Rentals</h3>
                <p>Rent for a day, a week, or longer with our flexible rental options.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <h3>Competitive Rates</h3>
                <p>Get the best value with our affordable rental rates and special offers.</p>
            </div>
        </div>
    </section>

    <section class="vehicle-types-section">
        <div class="vehicle-types">
            <h2>Explore Our Vehicle Types</h2>
            <div class="vehicle-type-cards">
                <div class="vehicle-type-card">
                    <img src="${pageContext.request.contextPath}/images/car-category.jpg" alt="Car" onerror="this.src='https://via.placeholder.com/400x250?text=Cars'">
                    <div class="vehicle-type-card-body">
                        <h3>Cars</h3>
                        <p>Sedans, SUVs, luxury cars, and more.</p>
                        <a href="${pageContext.request.contextPath}/vehicles/catalog?type=CAR" class="btn btn-primary mt-2">Browse Cars</a>
                    </div>
                </div>
                <div class="vehicle-type-card">
                    <img src="${pageContext.request.contextPath}/images/motorcycle-category.jpg" alt="Motorcycle" onerror="this.src='https://via.placeholder.com/400x250?text=Motorcycles'">
                    <div class="vehicle-type-card-body">
                        <h3>Motorcycles</h3>
                        <p>Sport bikes, cruisers, touring motorcycles.</p>
                        <a href="${pageContext.request.contextPath}/vehicles/catalog?type=MOTORCYCLE" class="btn btn-primary mt-2">Browse Motorcycles</a>
                    </div>
                </div>
                <div class="vehicle-type-card">
                    <img src="${pageContext.request.contextPath}/images/truck-category.jpg" alt="Truck" onerror="this.src='https://via.placeholder.com/400x250?text=Trucks'">
                    <div class="vehicle-type-card-body">
                        <h3>Trucks</h3>
                        <p>Pickup trucks, moving trucks, vans.</p>
                        <a href="${pageContext.request.contextPath}/vehicles/catalog?type=TRUCK" class="btn btn-primary mt-2">Browse Trucks</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="how-it-works-section">
        <div class="how-it-works">
            <h2>How It Works</h2>
            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Register an Account</h3>
                    <p>Sign up for a free account to access our rental services.</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Browse Vehicles</h3>
                    <p>Explore our diverse selection of vehicles and find the perfect match.</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>Book Your Rental</h3>
                    <p>Select your dates and complete the booking process.</p>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <h3>Pick Up & Enjoy</h3>
                    <p>Pick up your vehicle and enjoy your journey!</p>
                </div>
            </div>
        </div>
    </section>
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