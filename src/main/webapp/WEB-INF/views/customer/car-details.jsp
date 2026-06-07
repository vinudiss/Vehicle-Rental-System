<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${vehicle.make} ${vehicle.model} - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="vehicle-details-container">
        <div class="vehicle-image">
            <img src="${pageContext.request.contextPath}${vehicle.imageUrl}"
                 alt="${vehicle.make} ${vehicle.model}"
                 onerror="this.src='https://via.placeholder.com/600x400?text=Vehicle'">
        </div>

        <div class="vehicle-info">
            <h1>${vehicle.make} ${vehicle.model} (${vehicle.year})</h1>

            <div class="vehicle-status ${vehicle.available ? 'available' : 'unavailable'}">
                ${vehicle.available ? 'Available' : 'Currently Unavailable'}
            </div>

            <div class="vehicle-price">
                <h2>$${vehicle.dailyRate} <span class="price-unit">per day</span></h2>
            </div>

            <div class="vehicle-actions">
                <c:if test="${vehicle.available && not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/rentals/new?vehicleId=${vehicle.vehicleId}" class="btn btn-success">Rent Now</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-secondary">Back to Catalog</a>
            </div>

            <div class="vehicle-specs">
                <h3>Vehicle Specifications</h3>
                <div class="spec-grid">
                    <c:if test="${vehicle.vehicleType == 'CAR'}">
                        <!-- Car-specific details -->
                        <div class="spec-item">
                            <span class="spec-label">Type:</span>
                            <span class="spec-value">Car</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Category:</span>
                            <span class="spec-value">${vehicle.category}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Body Type:</span>
                            <span class="spec-value">${vehicle.bodyType}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Doors:</span>
                            <span class="spec-value">${vehicle.numberOfDoors}</span>
                        </div>
                    </c:if>

                    <c:if test="${vehicle.vehicleType == 'MOTORCYCLE'}">
                        <!-- Motorcycle-specific details -->
                        <div class="spec-item">
                            <span class="spec-label">Type:</span>
                            <span class="spec-value">Motorcycle</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Category:</span>
                            <span class="spec-value">${vehicle.category}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Engine:</span>
                            <span class="spec-value">${vehicle.engineCapacity} cc</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">License Req:</span>
                            <span class="spec-value">${vehicle.licenseRequirement}</span>
                        </div>
                    </c:if>

                    <c:if test="${vehicle.vehicleType == 'TRUCK'}">
                        <!-- Truck-specific details -->
                        <div class="spec-item">
                            <span class="spec-label">Type:</span>
                            <span class="spec-value">Truck</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Category:</span>
                            <span class="spec-value">${vehicle.category}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Cargo Capacity:</span>
                            <span class="spec-value">${vehicle.cargoCapacity} m³</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Max Load:</span>
                            <span class="spec-value">${vehicle.maxLoadWeight} kg</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Length:</span>
                            <span class="spec-value">${vehicle.length} m</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">License Req:</span>
                            <span class="spec-value">${vehicle.licenseRequirement}</span>
                        </div>
                    </c:if>

                    <!-- Common details for all vehicles -->
                    <div class="spec-item">
                        <span class="spec-label">Color:</span>
                        <span class="spec-value">${vehicle.color}</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Seating Capacity:</span>
                        <span class="spec-value">${vehicle.seatingCapacity}</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Fuel Type:</span>
                        <span class="spec-value">${vehicle.fuelType}</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Transmission:</span>
                        <span class="spec-value">${vehicle.transmissionType}</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">License Plate:</span>
                        <span class="spec-value">${vehicle.licensePlate}</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Current Location:</span>
                        <span class="spec-value">${vehicle.currentLocation}</span>
                    </div>
                </div>

                <h3>Features</h3>
                <ul class="feature-list">
                    <c:if test="${vehicle.vehicleType == 'CAR'}">
                        <!-- Car features -->
                        <li class="${vehicle.hasGPS ? '' : 'unavailable'}">
                            GPS Navigation
                        </li>
                        <li class="${vehicle.hasBluetoothConnectivity ? '' : 'unavailable'}">
                            Bluetooth Connectivity
                        </li>
                        <li class="${vehicle.hasSunroof ? '' : 'unavailable'}">
                            Sunroof
                        </li>
                    </c:if>

                    <c:if test="${vehicle.vehicleType == 'MOTORCYCLE'}">
                        <!-- Motorcycle features -->
                        <li class="${vehicle.hasABS ? '' : 'unavailable'}">
                            Anti-lock Braking System (ABS)
                        </li>
                        <li class="${vehicle.hasTractionControl ? '' : 'unavailable'}">
                            Traction Control
                        </li>
                    </c:if>

                    <c:if test="${vehicle.vehicleType == 'TRUCK'}">
                        <!-- Truck features -->
                        <li class="${vehicle.hasLiftGate ? '' : 'unavailable'}">
                            Lift Gate
                        </li>
                        <li class="${vehicle.hasHandTruck ? '' : 'unavailable'}">
                            Hand Truck
                        </li>
                        <li class="${vehicle.hasDolly ? '' : 'unavailable'}">
                            Dolly
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>