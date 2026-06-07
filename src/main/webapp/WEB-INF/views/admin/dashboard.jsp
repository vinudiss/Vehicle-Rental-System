<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Admin Dashboard</h1>

    <div class="dashboard-stats">
        <div class="stat-card">
            <i class="fas fa-users feature-icon"></i>
            <h3>Users</h3>
            <div class="stat-value">${userCount}</div>
            <a href="${pageContext.request.contextPath}/users/list" class="btn btn-sm btn-primary">Manage Users</a>
        </div>

        <div class="stat-card">
            <i class="fas fa-car feature-icon"></i>
            <h3>Vehicles</h3>
            <div class="stat-value">${vehicleCount}</div>
            <a href="${pageContext.request.contextPath}/vehicles/list" class="btn btn-sm btn-primary">Manage Vehicles</a>
        </div>

        <div class="stat-card">
            <i class="fas fa-calendar-check feature-icon"></i>
            <h3>Active Rentals</h3>
            <div class="stat-value">${activeRentalsCount}</div>
            <a href="${pageContext.request.contextPath}/rentals/list?status=active" class="btn btn-sm btn-primary">View Active Rentals</a>
        </div>

        <div class="stat-card">
            <i class="fas fa-exclamation-triangle feature-icon"></i>
            <h3>Overdue Rentals</h3>
            <div class="stat-value">${overdueRentalsCount}</div>
            <a href="${pageContext.request.contextPath}/rentals/list?status=overdue" class="btn btn-sm btn-primary">View Overdue Rentals</a>
        </div>
    </div>

    <div class="dashboard-actions">
        <h2>Quick Actions</h2>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/users/add?type=customer" class="btn btn-primary">Add New User</a>
            <a href="${pageContext.request.contextPath}/vehicles/add" class="btn btn-primary">Add New Vehicle</a>
            <a href="${pageContext.request.contextPath}/rentals/report" class="btn btn-primary">Generate Reports</a>
        </div>
    </div>

    <div class="recent-activity">
        <h2>Recent Activity</h2>
        <c:if test="${empty recentActivities}">
            <p>No recent activities found.</p>
        </c:if>

        <c:if test="${not empty recentActivities}">
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>Activity</th>
                        <th>Details</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${recentActivities}" var="activity">
                        <tr>
                            <td><fmt:formatDate value="${activity.date}" pattern="MMM dd, yyyy HH:mm" /></td>
                            <td>${activity.type}</td>
                            <td>${activity.details}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <div class="recent-rentals">
        <h2>Recent Rentals</h2>
        <c:if test="${empty recentRentals}">
            <p>No recent rentals found.</p>
        </c:if>

        <c:if test="${not empty recentRentals}">
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Vehicle</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${recentRentals}" var="rental">
                        <tr>
                            <td>${rental.rentalId}</td>
                            <td>${rental.customerName}</td>
                            <td>${rental.vehicleDetails}</td>
                            <td><fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" /></td>
                            <td><fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" /></td>
                            <td>${rental.status}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/rentals/view/${rental.rentalId}" class="btn btn-sm btn-primary">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>