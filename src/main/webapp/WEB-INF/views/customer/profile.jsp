<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>My Profile</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="profile-container">
        <div class="profile-card">
            <div class="profile-header">
                <h2>${customer.fullName}</h2>
                <p class="username">@${customer.username}</p>
                <p class="member-since">Member since: <fmt:formatDate value="${customer.registrationDate}" pattern="MMMM dd, yyyy" /></p>
            </div>

            <div class="profile-details">
                <div class="detail-item">
                    <span class="detail-label">Email:</span>
                    <span class="detail-value">${customer.email}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Phone:</span>
                    <span class="detail-value">${customer.phone}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Driver License:</span>
                    <span class="detail-value">${customer.driverLicense}</span>
                </div>
                <c:if test="${not empty customer.licenseExpiryDate}">
                    <div class="detail-item">
                        <span class="detail-label">License Expiry:</span>
                        <span class="detail-value">
                                <fmt:formatDate value="${customer.licenseExpiryDate}" pattern="MMMM dd, yyyy" />
                            </span>
                    </div>
                </c:if>
                <div class="detail-item">
                    <span class="detail-label">Last Login:</span>
                    <span class="detail-value">
                            <c:if test="${not empty customer.lastLogin}">
                                <fmt:formatDate value="${customer.lastLogin}" pattern="MMMM dd, yyyy 'at' HH:mm" />
                            </c:if>
                            <c:if test="${empty customer.lastLogin}">
                                First login
                            </c:if>
                        </span>
                </div>
            </div>

            <div class="profile-actions">
                <a href="${pageContext.request.contextPath}/customer/edit-profile" class="btn btn-primary">Edit Profile</a>
                <a href="${pageContext.request.contextPath}/customer/change-password" class="btn btn-secondary">Change Password</a>
            </div>

            <div class="rental-summary">
                <h3>Rental Summary</h3>
                <div class="dashboard-stats">
                    <div class="stat-card">
                        <i class="fas fa-car-side feature-icon"></i>
                        <h3>Active Rentals</h3>
                        <div class="stat-value">${activeRentalsCount}</div>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-history feature-icon"></i>
                        <h3>Total Rentals</h3>
                        <div class="stat-value">${customer.rentalHistory.size()}</div>
                    </div>
                </div>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/rentals/history" class="btn btn-primary">View Rental History</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>