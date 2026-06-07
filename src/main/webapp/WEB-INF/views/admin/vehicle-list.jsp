<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Vehicle Management - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Vehicle Management</h1>

    <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="admin-actions">
        <a href="${pageContext.request.contextPath}/vehicles/add?type=car" class="btn btn-primary">Add Car</a>
        <a href="${pageContext.request.contextPath}/vehicles/add?type=motorcycle" class="btn btn-primary">Add Motorcycle</a>
        <a href="${pageContext.request.contextPath}/vehicles/add?type=truck" class="btn btn-primary">Add Truck</a>
    </div>

    <div class="search-filter-section">
        <div class="search-section">
            <form action="${pageContext.request.contextPath}/vehicles/search" method="post" class="search-form">
                <div class="search-group">
                    <input type="text" name="searchTerm" placeholder="Search by make, model, or type..." value="${searchTerm}">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <c:if test="${not empty searchTerm}">
                        <a href="${pageContext.request.contextPath}/vehicles/list" class="btn btn-secondary">Clear</a>
                    </c:if>
                </div>
            </form>
        </div>

        <div class="filter-section">
            <form action="${pageContext.request.contextPath}/vehicles/filter" method="post" class="filter-form">
                <div class="filter-controls">
                    <div class="filter-group">
                        <label for="type">Type:</label>
                        <select id="type" name="type">
                            <option value="" ${selectedType == '' ? 'selected' : ''}>All Types</option>
                            <option value="CAR" ${selectedType == 'CAR' ? 'selected' : ''}>Cars</option>
                            <option value="MOTORCYCLE" ${selectedType == 'MOTORCYCLE' ? 'selected' : ''}>Motorcycles</option>
                            <option value="TRUCK" ${selectedType == 'TRUCK' ? 'selected' : ''}>Trucks</option>
                        </select>
                    </div>

                    <div class="filter-group filter-checkbox">
                        <label>
                            <input type="checkbox" name="onlyAvailable" ${onlyAvailable ? 'checked' : ''}>
                            Only available
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary">Apply Filters</button>
                </div>
            </form>
        </div>
    </div>

    <div class="vehicle-list">
        <c:if test="${empty vehicles}">
        <p class="no-results">No vehicles found.</p>
        </c:if>

        <c:if test="${not empty vehicles}">
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Make/Model</th>
                <th>Type</th>
                <th>Year</th>
                <th>License Plate</th>
                <th>Daily Rate</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${vehicles}" var="vehicle">
            <tr>
                <td>${vehicle.vehicleId}</td>
                <td class="image-cell">
                    <img src="${vehicle.imageUrl}" alt="${vehicle.make} ${vehicle.model}"
                         onerror="this.src='${pageContext.request.contextPath}/images/placeholder-vehicle-small.jpg'">
                </td>
                <td>${vehicle.make} ${vehicle.model}</td>
                <td>${vehicle.vehicleType}</td>
                <td>${vehicle.year}</td>
                <td>${vehicle.licensePlate}</td>
                <td>$${vehicle.dailyRate}/day</td>
                <td class="vehicle-status ${vehicle.available ? 'available' : 'unavailable'}">
                        ${vehicle.available ? 'Available' : 'Unavailable'}
                </td>
                <td class="actions-cell">
                    <a href="${pageContext.request.contextPath}/vehicles/view/${vehicle.vehicleId}" class="btn btn-sm">View</a>
                    <a href="${pageContext.request.contextPath}/vehicles/edit/${vehicle.vehicleId}" class="btn btn-sm">Edit</a>
                    <form action="${pageContext.request.contextPath}/vehicles/delete/${vehicle.vehicleId}" method="post" class="inline-form" onsubmit="return confirm('Are you sure you want to delete this vehicle?');">
                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                    </form>
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