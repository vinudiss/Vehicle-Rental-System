package com.rental.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Year;

/**
 * Car class extends Vehicle
 * Represents a car in the rental system
 */
public class Car extends Vehicle {
    private String category; // Economy, Compact, Standard, Full-size, Premium, Luxury, etc.
    private String bodyType; // Sedan, SUV, Hatchback, Convertible, etc.
    private int numberOfDoors;
    private boolean hasGPS;
    private boolean hasBluetoothConnectivity;
    private boolean hasSunroof;

    public Car() {
        super();
    }

    public Car(String vehicleId, String make, String model, Year year, String licensePlate,
               String color, BigDecimal dailyRate, String imageUrl, String currentLocation,
               int seatingCapacity, String fuelType, String transmissionType,
               LocalDate lastMaintenanceDate, int mileage, String category, String bodyType,
               int numberOfDoors, boolean hasGPS, boolean hasBluetoothConnectivity, boolean hasSunroof) {
        super(vehicleId, make, model, year, licensePlate, color, dailyRate, imageUrl,
                currentLocation, seatingCapacity, fuelType, transmissionType, lastMaintenanceDate, mileage);
        this.category = category;
        this.bodyType = bodyType;
        this.numberOfDoors = numberOfDoors;
        this.hasGPS = hasGPS;
        this.hasBluetoothConnectivity = hasBluetoothConnectivity;
        this.hasSunroof = hasSunroof;
    }

    @Override
    public String getVehicleType() {
        return "CAR";
    }

    @Override
    public String toFileString() {
        // Add car-specific fields to the base vehicle file string
        return super.toFileString() + "|" +
                category + "|" +
                bodyType + "|" +
                numberOfDoors + "|" +
                hasGPS + "|" +
                hasBluetoothConnectivity + "|" +
                hasSunroof;
    }

    // Static method to parse a Car from a file string
    public static Car fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 22) {
            throw new IllegalArgumentException("Invalid file string format for Car");
        }

        // Parse the base Vehicle fields
        Car car = (Car) Vehicle.fromFileString(fileString);

        // Parse Car-specific fields
        car.setCategory(parts[16]);
        car.setBodyType(parts[17]);
        car.setNumberOfDoors(Integer.parseInt(parts[18]));
        car.setHasGPS(Boolean.parseBoolean(parts[19]));
        car.setHasBluetoothConnectivity(Boolean.parseBoolean(parts[20]));
        car.setHasSunroof(Boolean.parseBoolean(parts[21]));

        return car;
    }

    // Getters and Setters
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBodyType() {
        return bodyType;
    }

    public void setBodyType(String bodyType) {
        this.bodyType = bodyType;
    }

    public int getNumberOfDoors() {
        return numberOfDoors;
    }

    public void setNumberOfDoors(int numberOfDoors) {
        this.numberOfDoors = numberOfDoors;
    }

    public boolean isHasGPS() {
        return hasGPS;
    }

    public void setHasGPS(boolean hasGPS) {
        this.hasGPS = hasGPS;
    }

    public boolean isHasBluetoothConnectivity() {
        return hasBluetoothConnectivity;
    }

    public void setHasBluetoothConnectivity(boolean hasBluetoothConnectivity) {
        this.hasBluetoothConnectivity = hasBluetoothConnectivity;
    }

    public boolean isHasSunroof() {
        return hasSunroof;
    }

    public void setHasSunroof(boolean hasSunroof) {
        this.hasSunroof = hasSunroof;
    }

    @Override
    public String toString() {
        return "Car{" +
                "vehicleId='" + getVehicleId() + '\'' +
                ", make='" + getMake() + '\'' +
                ", model='" + getModel() + '\'' +
                ", year=" + getYear() +
                ", category='" + category + '\'' +
                ", bodyType='" + bodyType + '\'' +
                ", numberOfDoors=" + numberOfDoors +
                ", dailyRate=" + getDailyRate() +
                ", available=" + isAvailable() +
                '}';
    }
}