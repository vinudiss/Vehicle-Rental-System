<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add Car - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>Add New Car</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="vehicle-form-container">
        <form action="${pageContext.request.contextPath}/vehicles/add" method="post" class="vehicle-form">
            <input type="hidden" name="vehicleType" value="CAR">

            <div class="form-section">
                <h3>General Information</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="make">Make:</label>
                        <input type="text" id="make" name="make" required>
                    </div>
                    <div class="form-group">
                        <label for="model">Model:</label>
                        <input type="text" id="model" name="model" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="year">Year:</label>
                        <input type="number" id="year" name="year" min="1900" max="2099" step="1" required>
                    </div>
                    <div class="form-group">
                        <label for="licensePlate">License Plate:</label>
                        <input type="text" id="licensePlate" name="licensePlate" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="color">Color:</label>
                        <input type="text" id="color" name="color" required>
                    </div>
                    <div class="form-group">
                        <label for="dailyRate">Daily Rate ($):</label>
                        <input type="number" id="dailyRate" name="dailyRate" min="0" step="0.01" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="mileage">Mileage:</label>
                        <input type="number" id="mileage" name="mileage" min="0" required>
                    </div>
                    <div class="form-group">
                        <label for="currentLocation">Current Location:</label>
                        <input type="text" id="currentLocation" name="currentLocation" required>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3>Vehicle Specifications</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="fuelType">Fuel Type:</label>
                        <select id="fuelType" name="fuelType" required>
                            <option value="Gasoline">Gasoline</option>
                            <option value="Diesel">Diesel</option>
                            <option value="Electric">Electric</option>
                            <option value="Hybrid">Hybrid</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="transmissionType">Transmission:</label>
                        <select id="transmissionType" name="transmissionType" required>
                            <option value="Automatic">Automatic</option>
                            <option value="Manual">Manual</option>
                            <option value="CVT">CVT</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="seatingCapacity">Seating Capacity:</label>
                        <input type="number" id="seatingCapacity" name="seatingCapacity" min="1" max="15" required>
                    </div>
                    <div class="form-group">
                        <label for="imageUrl">Image URL:</label>
                        <input type="text" id="imageUrl" name="imageUrl">
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3>Car Specific Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="category">Category:</label>
                        <select id="category" name="category" required>
                            <option value="Economy">Economy</option>
                            <option value="Compact">Compact</option>
                            <option value="Standard">Standard</option>
                            <option value="Full-size">Full-size</option>
                            <option value="Premium">Premium</option>
                            <option value="Luxury">Luxury</option>
                            <option value="SUV">SUV</option>
                            <option value="Minivan">Minivan</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="bodyType">Body Type:</label>
                        <select id="bodyType" name="bodyType" required>
                            <option value="Sedan">Sedan</option>
                            <option value="SUV">SUV</option>
                            <option value="Hatchback">Hatchback</option>
                            <option value="Coupe">Coupe</option>
                            <option value="Convertible">Convertible</option>
                            <option value="Minivan">Minivan</option>
                            <option value="Pickup">Pickup</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="numberOfDoors">Number of Doors:</label>
                        <input type="number" id="numberOfDoors" name="numberOfDoors" min="2" max="6" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" id="hasGPS" name="hasGPS" value="true">
                            GPS Navigation
                        </label>
                    </div>
                    <div class="form-group checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" id="hasBluetoothConnectivity" name="hasBluetoothConnectivity" value="true">
                            Bluetooth Connectivity
                        </label>
                    </div>
                    <div class="form-group checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" id="hasSunroof" name="hasSunroof" value="true">
                            Sunroof
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-group form-actions">
                <button type="submit" class="btn btn-primary">Add Car</button>
                <a href="${pageContext.request.contextPath}/vehicles/list" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>