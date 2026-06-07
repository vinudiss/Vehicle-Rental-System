<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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