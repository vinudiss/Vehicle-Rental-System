<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Edit Profile</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="profile-container">
        <div class="profile-card">
            <form action="${pageContext.request.contextPath}/customer/update-profile" method="post" class="profile-form">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" value="${customer.username}" class="form-control" disabled>
                    <span class="form-hint">Username cannot be changed</span>
                </div>

                <div class="form-group">
                    <label for="fullName" class="required">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" value="${customer.fullName}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="email" class="required">Email:</label>
                    <input type="email" id="email" name="email" value="${customer.email}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="phone" class="required">Phone Number:</label>
                    <input type="tel" id="phone" name="phone" value="${customer.phone}" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="driverLicense" class="required">Driver License Number:</label>
                    <input type="text" id="driverLicense" name="driverLicense" value="${customer.driverLicense}" class="form-control" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/customer/profile" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
    // Form validation
    document.querySelector('.profile-form').addEventListener('submit', function(event) {
        const fullName = document.getElementById('fullName').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const driverLicense = document.getElementById('driverLicense').value.trim();

        if (!fullName) {
            event.preventDefault();
            alert('Full name is required');
            return;
        }

        if (!email) {
            event.preventDefault();
            alert('Email is required');
            return;
        }

        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!emailPattern.test(email)) {
            event.preventDefault();
            alert('Please enter a valid email address');
            return;
        }

        if (!phone) {
            event.preventDefault();
            alert('Phone number is required');
            return;
        }

        if (!driverLicense) {
            event.preventDefault();
            alert('Driver license number is required');
            return;
        }
    });
</script>
</body>
</html>