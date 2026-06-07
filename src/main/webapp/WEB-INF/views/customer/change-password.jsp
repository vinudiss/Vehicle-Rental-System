<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Change Password</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="profile-container">
        <div class="profile-card">
            <form action="${pageContext.request.contextPath}/customer/change-password" method="post" id="passwordForm" class="password-form">
                <div class="form-group">
                    <label for="currentPassword" class="required">Current Password:</label>
                    <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="newPassword" class="required">New Password:</label>
                    <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                    <span class="form-hint">At least 8 characters with 1 uppercase, 1 lowercase, and 1 digit</span>
                </div>

                <div class="form-group">
                    <label for="confirmPassword" class="required">Confirm New Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
                </div>

                <div id="password-error" class="alert alert-danger" style="display: none;"></div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Change Password</button>
                    <a href="${pageContext.request.contextPath}/customer/profile" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
    // Form validation
    document.getElementById('passwordForm').addEventListener('submit', function(event) {
        const currentPassword = document.getElementById('currentPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const passwordError = document.getElementById('password-error');

        if (!currentPassword) {
            event.preventDefault();
            passwordError.textContent = "Current password is required";
            passwordError.style.display = "block";
            return;
        }

        if (!newPassword) {
            event.preventDefault();
            passwordError.textContent = "New password is required";
            passwordError.style.display = "block";
            return;
        }

        // Check if passwords match
        if (newPassword !== confirmPassword) {
            event.preventDefault();
            passwordError.textContent = "Passwords do not match";
            passwordError.style.display = "block";
            return;
        }

        // Check password strength
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$/;
        if (!passwordRegex.test(newPassword)) {
            event.preventDefault();
            passwordError.textContent = "Password must be at least 8 characters with 1 uppercase, 1 lowercase, and 1 digit";
            passwordError.style.display = "block";
            return;
        }
    });
</script>
</body>
</html>