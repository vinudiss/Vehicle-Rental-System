<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Catalog - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Vehicle Catalog</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="filter-section">
        <form action="${pageContext.request.contextPath}/vehicles/filter" method="post" class="filter-form">
            <div class="filter-group">
                <label for="type">Vehicle Type:</label>
                <select id="type" name="type">
                    <option value="" ${selectedType == '' ? 'selected' : ''}>All Types</option>
                    <option value="CAR" ${selectedType == 'CAR' ? 'selected' : ''}>Cars (${carCount})</option>
                    <option value="MOTORCYCLE" ${selectedType == 'MOTORCYCLE' ? 'selected' : ''}>Motorcycles (${motorcycleCount})</option>
                    <option value="TRUCK" ${selectedType == 'TRUCK' ? 'selected' : ''}>Trucks (${truckCount})</option>
                </select>
            </div>

            <div class="filter-group">
                <label for="minPrice">Min Price:</label>
                <input type="number" id="minPrice" name="minPrice" min="0" value="${minPrice}">
            </div>

            <div class="filter-group">
                <label for="maxPrice">Max Price:</label>
                <input type="number" id="maxPrice" name="maxPrice" min="0" value="${maxPrice}">
            </div>

            <div class="filter-group filter-checkbox">
                <label>
                    <input type="checkbox" name="onlyAvailable" ${onlyAvailable ? 'checked' : ''}>
                    Show only available vehicles
                </label>
            </div>

            <button type="submit" class="btn btn-primary">Apply Filters</button>
        </form>

        <form action="${pageContext.request.contextPath}/vehicles/search" method="post" class="search-form">
            <div class="search-group">
                <input type="text" name="searchTerm" placeholder="Search by make or model..." value="${searchTerm}">
                <button type="submit" class="btn btn-primary">Search</button>
                <c:if test="${not empty searchTerm}">
                    <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-secondary">Clear</a>
                </c:if>
            </div>
        </form>
    </div>

    <div class="vehicle-catalog">
        <c:if test="${empty vehicles}">
            <p class="no-results">No vehicles found matching your criteria.</p>
        </c:if>

        <div class="vehicle-grid">
            <c:forEach items="${vehicles}" var="vehicle">
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
                            <c:if test="${vehicle.available && not empty sessionScope.user}">
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