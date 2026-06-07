<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Rental Management - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Rental Management</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="filter-section">
        <div class="filter-buttons">
            <a href="${pageContext.request.contextPath}/rentals/list" class="btn ${filterStatus == 'all' ? 'btn-primary' : 'btn-outline'}">All Rentals</a>
            <a href="${pageContext.request.contextPath}/rentals/list?status=active" class="btn ${filterStatus == 'active' ? 'btn-primary' : 'btn-outline'}">Active</a>
            <a href="${pageContext.request.contextPath}/rentals/list?status=completed" class="btn ${filterStatus == 'completed' ? 'btn-primary' : 'btn-outline'}">Completed</a>
            <a href="${pageContext.request.contextPath}/rentals/list?status=overdue" class="btn ${filterStatus == 'overdue' ? 'btn-primary' : 'btn-outline'}">Overdue</a>
        </div>

        <form action="${pageContext.request.contextPath}/rentals/search" method="post" class="search-form">
            <div class="search-group">
                <input type="text" name="userId" placeholder="User ID" value="${searchUserId}">
                <input type="text" name="vehicleId" placeholder="Vehicle ID" value="${searchVehicleId}">
                <select name="status">
                    <option value="" ${searchStatus == '' ? 'selected' : ''}>All Statuses</option>
                    <option value="RESERVED" ${searchStatus == 'RESERVED' ? 'selected' : ''}>Reserved</option>
                    <option value="ACTIVE" ${searchStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                    <option value="COMPLETED" ${searchStatus == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    <option value="CANCELLED" ${searchStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <div class="rental-list">
        <c:if test="${empty rentals}">
            <p class="no-results">No rentals found.</p>
        </c:if>

        <c:if test="${not empty rentals}">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>User</th>
                    <th>Vehicle</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Total Cost</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${rentals}" var="rental">
                    <tr>
                        <td>${rental.rentalId}</td>
                        <td>${rental.userDetails != null ? rental.userDetails.fullName : rental.userId}</td>
                        <td>${rental.vehicleDetails != null ? rental.vehicleDetails.make : ''} ${rental.vehicleDetails != null ? rental.vehicleDetails.model : rental.vehicleId}</td>
                        <td><fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" /></td>
                        <td><fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" /></td>
                        <td class="rental-status ${rental.status}">
                                ${rental.status}
                            <c:if test="${rental.isOverdue()}">
                                <span class="overdue-badge">OVERDUE</span>
                            </c:if>
                        </td>
                        <td class="payment-status ${rental.paymentStatus}">
                                ${rental.paymentStatus}
                        </td>
                        <td>$${rental.totalCost}</td>
                        <td class="actions-cell">
                            <a href="${pageContext.request.contextPath}/rentals/view/${rental.rentalId}" class="btn btn-sm">View</a>

                            <c:if test="${rental.status == 'RESERVED'}">
                                <a href="${pageContext.request.contextPath}/rentals/pickup/${rental.rentalId}" class="btn btn-sm btn-success">Pickup</a>
                                <a href="${pageContext.request.contextPath}/rentals/cancel/${rental.rentalId}" class="btn btn-sm btn-danger">Cancel</a>
                            </c:if>

                            <c:if test="${rental.status == 'ACTIVE'}">
                                <a href="${pageContext.request.contextPath}/rentals/return/${rental.rentalId}" class="btn btn-sm btn-success">Return</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>