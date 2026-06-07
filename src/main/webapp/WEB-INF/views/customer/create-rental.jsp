<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rent a Vehicle - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Rent a Vehicle</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="rental-form-container">
        <c:if test="${not empty vehicle}">
            <div class="selected-vehicle">
                <h2>Selected Vehicle</h2>
                <div class="vehicle-card">
                    <img src="${pageContext.request.contextPath}${vehicle.imageUrl}"
                         alt="${vehicle.make} ${vehicle.model}"
                         onerror="this.src='https://via.placeholder.com/300x200?text=Vehicle'">
                    <div class="vehicle-details">
                        <h3>${vehicle.make} ${vehicle.model}</h3>
                        <p>Year: ${vehicle.year}</p>
                        <p>Type: ${vehicle.vehicleType}</p>
                        <p>Rate: $${vehicle.dailyRate}/day</p>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty vehicle}">
            <div class="vehicle-selection">
                <h2>Select a Vehicle</h2>
                <div class="form-group">
                    <label for="vehicleId" class="required">Choose a vehicle:</label>
                    <select id="vehicleId" name="vehicleId" form="rentalForm" required>
                        <option value="">-- Select a vehicle --</option>
                        <c:forEach items="${availableVehicles}" var="vehicle">
                            <option value="${vehicle.vehicleId}" data-daily-rate="${vehicle.dailyRate}">
                                    ${vehicle.make} ${vehicle.model} (${vehicle.year}) - $${vehicle.dailyRate}/day
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </c:if>

        <form id="rentalForm" action="${pageContext.request.contextPath}/rentals/create" method="post" class="rental-form">
            <c:if test="${not empty vehicle}">
                <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}" data-daily-rate="${vehicle.dailyRate}">
            </c:if>

            <div class="form-group">
                <label for="startDate" class="required">Pickup Date:</label>
                <input type="date" id="startDate" name="startDate" required
                       min="<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' />">
            </div>

            <div class="form-group">
                <label for="endDate" class="required">Return Date:</label>
                <input type="date" id="endDate" name="endDate" required
                       min="<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' />">
            </div>

            <div class="form-group">
                <label for="pickupLocation" class="required">Pickup Location:</label>
                <input type="text" id="pickupLocation" name="pickupLocation" required>
            </div>

            <div class="form-group">
                <label for="returnLocation" class="required">Return Location:</label>
                <input type="text" id="returnLocation" name="returnLocation" required>
            </div>

            <div id="rentalSummary" class="rental-summary">
                <h3>Rental Summary</h3>
                <div id="summaryContent">
                    <p>Please select dates to see the rental summary</p>
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-primary">Confirm Rental</button>
                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />

<script>
    // Simple client-side validation and rental cost calculation
    document.addEventListener('DOMContentLoaded', function() {
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        const vehicleSelect = document.getElementById('vehicleId');
        const summaryContent = document.getElementById('summaryContent');
        const rentalForm = document.getElementById('rentalForm');

        // Set minimum date to today
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const todayStr = yyyy + '-' + mm + '-' + dd;

        startDateInput.min = todayStr;
        endDateInput.min = todayStr;

        // Function to update the rental summary
        function updateRentalSummary() {
            // Get selected dates
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            // Validate dates
            if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
                summaryContent.innerHTML = '<p>Please select valid dates</p>';
                return;
            }

            if (startDate > endDate) {
                summaryContent.innerHTML = '<p class="text-danger">Return date must be after pickup date</p>';
                return;
            }

            // Calculate duration in days
            const durationMs = endDate - startDate;
            const durationDays = Math.ceil(durationMs / (1000 * 60 * 60 * 24)) + 1; // Include both start and end days

            // Get vehicle rate
            let dailyRate = 0;
            let vehicleName = '';

            const selectedVehicleId = document.querySelector('input[name="vehicleId"]') ||
                (vehicleSelect && vehicleSelect.options[vehicleSelect.selectedIndex]);

            if (selectedVehicleId) {
                dailyRate = parseFloat(selectedVehicleId.dataset.dailyRate || 0);
                vehicleName = vehicleSelect ?
                    vehicleSelect.options[vehicleSelect.selectedIndex].text.split(' - ')[0] :
                    '${vehicle.make} ${vehicle.model} (${vehicle.year})';
            } else {
                summaryContent.innerHTML = '<p>Please select a vehicle</p>';
                return;
            }

            // Calculate costs
            const baseCost = dailyRate * durationDays;
            const insuranceFee = baseCost * 0.10; // 10% of base cost
            const totalCost = baseCost + insuranceFee;

            // Update summary
            summaryContent.innerHTML = `
                    <div class="cost-items">
                        <div class="cost-item">
                            <span class="cost-label">Vehicle:</span>
                            <span class="cost-value">${vehicleName}</span>
                        </div>
                        <div class="cost-item">
                            <span class="cost-label">Duration:</span>
                            <span class="cost-value">${durationDays} day(s)</span>
                        </div>
                        <div class="cost-item">
                            <span class="cost-label">Base Cost:</span>
                            <span class="cost-value">${baseCost.toFixed(2)}</span>
                        </div>
                        <div class="cost-item">
                            <span class="cost-label">Insurance Fee:</span>
                            <span class="cost-value">${insuranceFee.toFixed(2)}</span>
                        </div>
                        <div class="cost-item total-cost">
                            <span class="cost-label">Total Cost:</span>
                            <span class="cost-value">${totalCost.toFixed(2)}</span>
                        </div>
                    </div>
                `;
        }

        // Add event listeners
        if (startDateInput) {
            startDateInput.addEventListener('change', updateRentalSummary);
        }

        if (endDateInput) {
            endDateInput.addEventListener('change', updateRentalSummary);
        }

        if (vehicleSelect) {
            vehicleSelect.addEventListener('change', updateRentalSummary);
        }

        // Form validation
        if (rentalForm) {
            rentalForm.addEventListener('submit', function(event) {
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);

                if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
                    event.preventDefault();
                    alert('Please select valid dates');
                    return;
                }

                if (startDate > endDate) {
                    event.preventDefault();
                    alert('Return date must be after pickup date');
                    return;
                }

                const selectedVehicleId = document.querySelector('input[name="vehicleId"]') ||
                    (vehicleSelect && vehicleSelect.value);

                if (!selectedVehicleId || selectedVehicleId === '') {
                    event.preventDefault();
                    alert('Please select a vehicle');
                    return;
                }

                const pickupLocation = document.getElementById('pickupLocation').value;
                const returnLocation = document.getElementById('returnLocation').value;

                if (!pickupLocation || !returnLocation) {
                    event.preventDefault();
                    alert('Please enter pickup and return locations');
                    return;
                }
            });
        }
    });
</script>
</body>
</html>