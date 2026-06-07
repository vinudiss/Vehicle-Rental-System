<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Details - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Rental Details</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="rental-details-container">
        <div class="rental-card">
            <div class="rental-status ${rental.status}">
                Status: ${rental.status}
            </div>

            <div class="rental-header">
                <h2>Rental #${rental.rentalId}</h2>
                <div class="rental-dates">
                    <p>
                        <span class="date-label">Pickup:</span>
                        <fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" />
                    </p>
                    <p>
                        <span class="date-label">Return:</span>
                        <fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" />
                    </p>
                </div>
            </div>

            <div class="rental-vehicle">
                <h3>Vehicle Information</h3>
                <c:if test="${not empty vehicle}">
                    <div class="vehicle-card">
                        <img src="${pageContext.request.contextPath}${vehicle.imageUrl}"
                             alt="${vehicle.make} ${vehicle.model}"
                             onerror="this.src='https://via.placeholder.com/300x200?text=Vehicle'">
                        <div class="vehicle-details">
                            <h4>${vehicle.make} ${vehicle.model} (${vehicle.year})</h4>
                            <p>Type: ${vehicle.vehicleType}</p>
                            <p>License Plate: ${vehicle.licensePlate}</p>
                            <a href="${pageContext.request.contextPath}/vehicles/view/${vehicle.vehicleId}" class="btn btn-sm btn-primary">View Vehicle</a>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="rental-info">
                <h3>Rental Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Pickup Location:</span>
                        <span class="info-value">${rental.pickupLocation}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Return Location:</span>
                        <span class="info-value">${rental.returnLocation}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Pickup Time:</span>
                        <span class="info-value">
                                <c:if test="${not empty rental.pickupTime}">
                                    <fmt:formatDate value="${rental.pickupTime}" pattern="MMM dd, yyyy HH:mm" />
                                </c:if>
                                <c:if test="${empty rental.pickupTime}">
                                    Not picked up yet
                                </c:if>
                            </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Return Time:</span>
                        <span class="info-value">
                                <c:if test="${not empty rental.returnTime}">
                                    <fmt:formatDate value="${rental.returnTime}" pattern="MMM dd, yyyy HH:mm" />
                                </c:if>
                                <c:if test="${empty rental.returnTime}">
                                    Not returned yet
                                </c:if>
                            </span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Duration:</span>
                        <span class="info-value">${rental.calculateDuration()} day(s)</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Payment Status:</span>
                        <span class="info-value payment-status ${rental.paymentStatus}">${rental.paymentStatus}</span>
                    </div>
                </div>
            </div>

            <div class="rental-costs">
                <h3>Cost Breakdown</h3>
                <div class="cost-items">
                    <div class="cost-item">
                        <span class="cost-label">Daily Rate:</span>
                        <span class="cost-value">$${rental.basicRate}/day</span>
                    </div>
                    <div class="cost-item">
                        <span class="cost-label">Basic Rental Cost:</span>
                        <span class="cost-value">$${rental.basicRate * rental.calculateDuration()}</span>
                    </div>
                    <div class="cost-item">
                        <span class="cost-label">Insurance Fee:</span>
                        <span class="cost-value">$${rental.insuranceFee}</span>
                    </div>
                    <div class="cost-item">
                        <span class="cost-label">Additional Fees:</span>
                        <span class="cost-value">$${rental.additionalFees}</span>
                    </div>

                    <c:if test="${rental.isOverdue() && not empty lateFees}">
                        <div class="cost-item late-fee">
                            <span class="cost-label">Late Fees:</span>
                            <span class="cost-value">$${lateFees}</span>
                        </div>
                    </c:if>

                    <div class="cost-item total-cost">
                        <span class="cost-label">Total Cost:</span>
                        <span class="cost-value">$${rental.totalCost}</span>
                    </div>
                </div>
            </div>

            <c:if test="${not empty rental.notes}">
                <div class="rental-notes">
                    <h3>Notes</h3>
                    <p>${rental.notes}</p>
                </div>
            </c:if>

            <div class="rental-actions">
                <!-- Admin-only actions -->
                <c:if test="${sessionScope.userType == 'ADMIN'}">
                    <c:if test="${rental.status == 'RESERVED'}">
                        <a href="${pageContext.request.contextPath}/rentals/pickup/${rental.rentalId}" class="btn btn-primary">Process Pickup</a>
                    </c:if>
                    <c:if test="${rental.status == 'ACTIVE'}">
                        <a href="${pageContext.request.contextPath}/rentals/return/${rental.rentalId}" class="btn btn-primary">Process Return</a>
                    </c:if>

                    <div class="payment-update">
                        <form action="${pageContext.request.contextPath}/rentals/payment/${rental.rentalId}" method="post" class="d-flex">
                            <select name="paymentStatus" class="form-control mr-2">
                                <option value="PENDING" ${rental.paymentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="PAID" ${rental.paymentStatus == 'PAID' ? 'selected' : ''}>Paid</option>
                                <option value="REFUNDED" ${rental.paymentStatus == 'REFUNDED' ? 'selected' : ''}>Refunded</option>
                            </select>
                            <button type="submit" class="btn btn-primary">Update Payment</button>
                        </form>
                    </div>
                </c:if>

                <!-- Customer-only actions -->
                <c:if test="${sessionScope.userType == 'CUSTOMER' && rental.status == 'RESERVED'}">
                    <a href="${pageContext.request.contextPath}/rentals/cancel/${rental.rentalId}" class="btn btn-danger">Cancel Rental</a>
                </c:if>

                <!-- Back button for all users -->
                <c:choose>
                    <c:when test="${sessionScope.userType == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/rentals/list" class="btn btn-secondary">Back to Rentals</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/rentals/list" class="btn btn-secondary">Back to My Rentals</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>