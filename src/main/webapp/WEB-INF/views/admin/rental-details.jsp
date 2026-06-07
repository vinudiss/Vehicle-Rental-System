<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Rental Details - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
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
                <c:if test="${rental.isOverdue()}">
                    <span class="overdue-badge">OVERDUE</span>
                </c:if>
            </div>

            <div class="rental-header">
                <h2>Rental #${rental.rentalId}</h2>
                <div class="rental-actions admin-actions">
                    <c:if test="${rental.status == 'RESERVED'}">
                        <a href="${pageContext.request.contextPath}/rentals/pickup/${rental.rentalId}" class="btn btn-success">Process Pickup</a>
                        <a href="${pageContext.request.contextPath}/rentals/cancel/${rental.rentalId}" class="btn btn-danger">Cancel Rental</a>
                    </c:if>
                    <c:if test="${rental.status == 'ACTIVE'}">
                        <a href="${pageContext.request.contextPath}/rentals/return/${rental.rentalId}" class="btn btn-success">Process Return</a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/rentals/list" class="btn btn-secondary">Back to List</a>
                </div>
            </div>

            <div class="rental-sections">
                <div class="rental-section">
                    <h3>Customer Information</h3>
                    <c:if test="${not empty customer}">
                        <div class="user-details">
                            <p><strong>Name:</strong> ${customer.fullName}</p>
                            <p><strong>Username:</strong> ${customer.username}</p>
                            <p><strong>Email:</strong> ${customer.email}</p>
                            <p><strong>Phone:</strong> ${customer.phone}</p>
                            <p><strong>Driver License:</strong> ${customer.driverLicense}</p>
                            <p><a href="${pageContext.request.contextPath}/users/view/${customer.userId}" class="btn btn-sm">View Customer Profile</a></p>
                        </div>
                    </c:if>
                    <c:if test="${empty customer}">
                        <p>Customer ID: ${rental.userId}</p>
                    </c:if>
                </div>

                <div class="rental-section">
                    <h3>Vehicle Information</h3>
                    <c:if test="${not empty vehicle}">
                        <div class="vehicle-details">
                            <div class="vehicle-image">
                                <img src="${vehicle.imageUrl}" alt="${vehicle.make} ${vehicle.model}"
                                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder-vehicle-small.jpg'">
                            </div>
                            <div class="vehicle-info">
                                <p><strong>Make/Model:</strong> ${vehicle.make} ${vehicle.model}</p>
                                <p><strong>Year:</strong> ${vehicle.year}</p>
                                <p><strong>Type:</strong> ${vehicle.vehicleType}</p>
                                <p><strong>License Plate:</strong> ${vehicle.licensePlate}</p>
                                <p><strong>Daily Rate:</strong> $${vehicle.dailyRate}</p>
                                <p><a href="${pageContext.request.contextPath}/vehicles/view/${vehicle.vehicleId}" class="btn btn-sm">View Vehicle Details</a></p>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${empty vehicle}">
                        <p>Vehicle ID: ${rental.vehicleId}</p>
                    </c:if>
                </div>
            </div>

            <div class="rental-info">
                <h3>Rental Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Pickup Date:</span>
                        <span class="info-value"><fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" /></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Return Date:</span>
                        <span class="info-value"><fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" /></span>
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
                        <span class="info-label">Pickup Location:</span>
                        <span class="info-value">${rental.pickupLocation}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Return Location:</span>
                        <span class="info-value">${rental.returnLocation}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Duration:</span>
                        <span class="info-value">${rental.calculateDuration()} day(s)</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Payment Status:</span>
                        <span class="info-value payment-status ${rental.paymentStatus}">${rental.paymentStatus}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Last Updated:</span>
                        <span class="info-value"><fmt:formatDate value="${rental.lastUpdated}" pattern="MMM dd, yyyy HH:mm" /></span>
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

            <div class="payment-management">
                <h3>Payment Management</h3>
                <form action="${pageContext.request.contextPath}/rentals/payment/${rental.rentalId}" method="post" class="payment-form">
                    <div class="form-group">
                        <label for="paymentStatus">Update Payment Status:</label>
                        <select id="paymentStatus" name="paymentStatus">
                            <option value="PENDING" ${rental.paymentStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                            <option value="PAID" ${rental.paymentStatus == 'PAID' ? 'selected' : ''}>Paid</option>
                            <option value="REFUNDED" ${rental.paymentStatus == 'REFUNDED' ? 'selected' : ''}>Refunded</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Payment</button>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>