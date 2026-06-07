<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:choose>
        <c:when test="${sessionScope.userType == 'ADMIN'}">
            <title>Manage Rentals - Vehicle Rental System</title>
        </c:when>
        <c:otherwise>
            <title>My Rentals - Vehicle Rental System</title>
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <c:choose>
        <c:when test="${sessionScope.userType == 'ADMIN'}">
            <h1>Manage Rentals</h1>
        </c:when>
        <c:otherwise>
            <h1>My Rentals</h1>
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Admin-only filter section -->
    <c:if test="${sessionScope.userType == 'ADMIN'}">
        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/rentals/list" method="get" class="filter-form">
                <div class="filter-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="all" ${filterStatus == 'all' ? 'selected' : ''}>All</option>
                        <option value="active" ${filterStatus == 'active' ? 'selected' : ''}>Active</option>
                        <option value="reserved" ${filterStatus == 'reserved' ? 'selected' : ''}>Reserved</option>
                        <option value="completed" ${filterStatus == 'completed' ? 'selected' : ''}>Completed</option>
                        <option value="cancelled" ${filterStatus == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                        <option value="overdue" ${filterStatus == 'overdue' ? 'selected' : ''}>Overdue</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Apply Filter</button>
            </form>

            <form action="${pageContext.request.contextPath}/rentals/search" method="post" class="search-form mt-3">
                <div class="search-group">
                    <input type="text" name="searchTerm" placeholder="Search by ID, customer, or vehicle..." value="${searchTerm}">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <c:if test="${not empty searchTerm}">
                        <a href="${pageContext.request.contextPath}/rentals/list" class="btn btn-secondary">Clear</a>
                    </c:if>
                </div>
            </form>
        </div>
    </c:if>

    <!-- Rentals table -->
    <c:if test="${empty rentals}">
        <p class="no-results">No rentals found.</p>
        <c:if test="${sessionScope.userType == 'CUSTOMER'}">
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-primary">Browse Vehicles to Rent</a>
            </div>
        </c:if>
    </c:if>

    <c:if test="${not empty rentals}">
        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <c:if test="${sessionScope.userType == 'ADMIN'}">
                        <th>Customer</th>
                    </c:if>
                    <th>Vehicle</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Payment</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${rentals}" var="rental">
                    <tr>
                        <td>${rental.rentalId}</td>
                        <c:if test="${sessionScope.userType == 'ADMIN'}">
                            <td>${rental.customerName}</td>
                        </c:if>
                        <td>${rental.vehicleDetails}</td>
                        <td><fmt:formatDate value="${rental.startDate}" pattern="MMM dd, yyyy" /></td>
                        <td><fmt:formatDate value="${rental.endDate}" pattern="MMM dd, yyyy" /></td>
                        <td class="${rental.isOverdue() ? 'text-danger' : ''}">${rental.status}${rental.isOverdue() ? ' (OVERDUE)' : ''}</td>
                        <td>${rental.paymentStatus}</td>
                        <td>$${rental.totalCost}</td>
                        <td class="actions-cell">
                            <a href="${pageContext.request.contextPath}/rentals/view/${rental.rentalId}" class="btn btn-sm btn-primary">View</a>

                            <!-- Admin-specific actions -->
                            <c:if test="${sessionScope.userType == 'ADMIN'}">
                                <c:if test="${rental.status == 'RESERVED'}">
                                    <a href="${pageContext.request.contextPath}/rentals/pickup/${rental.rentalId}" class="btn btn-sm btn-success">Pickup</a>
                                </c:if>
                                <c:if test="${rental.status == 'ACTIVE'}">
                                    <a href="${pageContext.request.contextPath}/rentals/return/${rental.rentalId}" class="btn btn-sm btn-success">Return</a>
                                </c:if>
                            </c:if>

                            <!-- Customer-specific actions -->
                            <c:if test="${sessionScope.userType == 'CUSTOMER' && rental.status == 'RESERVED'}">
                                <a href="${pageContext.request.contextPath}/rentals/cancel/${rental.rentalId}" class="btn btn-sm btn-danger">Cancel</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${sessionScope.userType == 'CUSTOMER'}">
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-primary">Rent Another Vehicle</a>
            </div>
        </c:if>
    </c:if>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>