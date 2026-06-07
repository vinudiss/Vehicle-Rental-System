<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Welcome, ${user.fullName}!</h1>

    <div class="dashboard-stats">
        <div class="stat-card">
            <i class="fas fa-car-side feature-icon"></i>
            <h3>Active Rentals</h3>
            <div class="stat-value">${activeRentalsCount}</div>
            <a href="${pageContext.request.contextPath}/rentals/list" class="btn btn-sm btn-primary">View My Rentals</a>
        </div>

        <div class="stat-card">
            <i class="fas fa-history feature-icon"></i>
            <h3>Total Rentals</h3>
            <div class="stat-value">${totalRentalsCount}</div>
            <a href="${pageContext.request.contextPath}/rentals/history" class="btn btn-sm btn-primary">View Rental History</a>
        </div>
    </div>

    <div class="dashboard-actions">
        <h2>Quick Actions</h2>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-primary">Browse Vehicles</a>
            <a href="${pageContext.request.contextPath}/rentals/new" class="btn btn-success">Rent a Vehicle</a>
            <a href="${pageContext.request.contextPath}/customer/profile" class="btn btn-secondary">My Profile</a>
        </div>
    </div>

    <div class="active-rentals">
        <h2>Your Active Rentals</h2>
        <c:if test="${empty activeRentals}">
            <p>You don't have any active rentals.</p>
        </c:if>

        <c:if test="${not empty activeRentals}">
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Vehicle</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${activeRentals}" var="rental">
                        <tr>
                            <td>${rental.vehicleDetails}</td>
                            <td><fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" /></td>
                            <td><fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" /></td>
                            <td>${rental.status}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/rentals/view/${rental.rentalId}" class="btn btn-sm btn-primary">View</a>
                                <c:if test="${rental.status == 'RESERVED'}">
                                    <a href="${pageContext.request.contextPath}/rentals/cancel/${rental.rentalId}" class="btn btn-sm btn-danger">Cancel</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <div class="featured-vehicles">
        <h2>Featured Vehicles</h2>
        <div class="vehicle-grid">
            <c:forEach items="${featuredVehicles}" var="vehicle">
                <div class="vehicle-card">
                    <img src="${pageContext.request.contextPath}${vehicle.imageUrl}"
                         alt="${vehicle.make} ${vehicle.model}"
                         onerror="this.src='https://via.placeholder.com/300x200?text=Vehicle'">
                    <div class="vehicle-details">
                        <span class="vehicle-type">${vehicle.vehicleType}</span>
                        <h3>${vehicle.make} ${vehicle.model}</h3>
                        <p>Year: ${vehicle.year}</p>
                        <div class="vehicle-price">$${vehicle.dailyRate}/day</div>
                        <span class="vehicle-availability ${vehicle.available ? 'available' : 'unavailable'}">
                                ${vehicle.available ? 'Available' : 'Currently Unavailable'}
                        </span>
                        <div class="vehicle-actions">
                            <a href="${pageContext.request.contextPath}/vehicles/view/${vehicle.vehicleId}" class="btn btn-primary">View Details</a>
                            <c:if test="${vehicle.available}">
                                <a href="${pageContext.request.contextPath}/rentals/new?vehicleId=${vehicle.vehicleId}" class="btn btn-success">Rent Now</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>