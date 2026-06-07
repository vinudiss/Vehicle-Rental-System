package com.rental.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Year;

/**
 * Truck class extends Vehicle
 * Represents a truck in the rental system
 */
public class Truck extends Vehicle {
    private String category; // Pickup, Van, Box truck, Moving truck, etc.
    private double cargoCapacity; // in cubic meters
    private double maxLoadWeight; // in kg
    private double length; // in meters
    private boolean hasLiftGate;
    private boolean hasHandTruck;
    private boolean hasDolly;
    private String licenseRequirement; // Standard, Commercial, etc.

    public Truck() {
        super();
    }

    public Truck(String vehicleId, String make, String model, Year year, String licensePlate,
                 String color, BigDecimal dailyRate, String imageUrl, String currentLocation,
                 int seatingCapacity, String fuelType, String transmissionType,
                 LocalDate lastMaintenanceDate, int mileage, String category, double cargoCapacity,
                 double maxLoadWeight, double length, boolean hasLiftGate, boolean hasHandTruck,
                 boolean hasDolly, String licenseRequirement) {
        super(vehicleId, make, model, year, licensePlate, color, dailyRate, imageUrl,
                currentLocation, seatingCapacity, fuelType, transmissionType, lastMaintenanceDate, mileage);
        this.category = category;
        this.cargoCapacity = cargoCapacity;
        this.maxLoadWeight = maxLoadWeight;
        this.length = length;
        this.hasLiftGate = hasLiftGate;
        this.hasHandTruck = hasHandTruck;
        this.hasDolly = hasDolly;
        this.licenseRequirement = licenseRequirement;
    }

    @Override
    public String getVehicleType() {
        return "TRUCK";
    }

    @Override
    public String toFileString() {
        // Add truck-specific fields to the base vehicle file string
        return super.toFileString() + "|" +
                category + "|" +
                cargoCapacity + "|" +
                maxLoadWeight + "|" +
                length + "|" +
                hasLiftGate + "|" +
                hasHandTruck + "|" +
                hasDolly + "|" +
                licenseRequirement;
    }

    // Static method to parse a Truck from a file string
    public static Truck fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 24) {
            throw new IllegalArgumentException("Invalid file string format for Truck");
        }

        // Parse the base Vehicle fields
        Truck truck = (Truck) Vehicle.fromFileString(fileString);

        // Parse Truck-specific fields
        truck.setCategory(parts[16]);
        truck.setCargoCapacity(Double.parseDouble(parts[17]));
        truck.setMaxLoadWeight(Double.parseDouble(parts[18]));
        truck.setLength(Double.parseDouble(parts[19]));
        truck.setHasLiftGate(Boolean.parseBoolean(parts[20]));
        truck.setHasHandTruck(Boolean.parseBoolean(parts[21]));
        truck.setHasDolly(Boolean.parseBoolean(parts[22]));
        truck.setLicenseRequirement(parts[23]);

        return truck;
    }

    // Calculate additional fees based on equipment
    public BigDecimal calculateEquipmentFees() {
        BigDecimal fees = BigDecimal.ZERO;

        if (hasLiftGate) {
            fees = fees.add(new BigDecimal("25.00"));
        }
        if (hasHandTruck) {
            fees = fees.add(new BigDecimal("10.00"));
        }
        if (hasDolly) {
            fees = fees.add(new BigDecimal("10.00"));
        }

        return fees;
    }

    // Getters and Setters
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getCargoCapacity() {
        return cargoCapacity;
    }

    public void setCargoCapacity(double cargoCapacity) {
        this.cargoCapacity = cargoCapacity;
    }

    public double getMaxLoadWeight() {
        return maxLoadWeight;
    }

    public void setMaxLoadWeight(double maxLoadWeight) {
        this.maxLoadWeight = maxLoadWeight;
    }

    public double getLength() {
        return length;
    }

    public void setLength(double length) {
        this.length = length;
    }

    public boolean isHasLiftGate() {
        return hasLiftGate;
    }

    public void setHasLiftGate(boolean hasLiftGate) {
        this.hasLiftGate = hasLiftGate;
    }

    public boolean isHasHandTruck() {
        return hasHandTruck;
    }

    public void setHasHandTruck(boolean hasHandTruck) {
        this.hasHandTruck = hasHandTruck;
    }

    public boolean isHasDolly() {
        return hasDolly;
    }

    public void setHasDolly(boolean hasDolly) {
        this.hasDolly = hasDolly;
    }

    public String getLicenseRequirement() {
        return licenseRequirement;
    }

    public void setLicenseRequirement(String licenseRequirement) {
        this.licenseRequirement = licenseRequirement;
    }

    @Override
    public String toString() {
        return "Truck{" +
                "vehicleId='" + getVehicleId() + '\'' +
                ", make='" + getMake() + '\'' +
                ", model='" + getModel() + '\'' +
                ", year=" + getYear() +
                ", category='" + category + '\'' +
                ", cargoCapacity=" + cargoCapacity + "m³" +
                ", maxLoadWeight=" + maxLoadWeight + "kg" +
                ", length=" + length + "m" +
                ", dailyRate=" + getDailyRate() +
                ", available=" + isAvailable() +
                '}';
    }
}