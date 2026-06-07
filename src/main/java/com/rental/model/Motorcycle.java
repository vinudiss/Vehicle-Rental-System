package com.rental.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.Year;

/**
 * Motorcycle class extends Vehicle
 * Represents a motorcycle in the rental system
 */
public class Motorcycle extends Vehicle {
    private String category; // Sport, Cruiser, Touring, Standard, etc.
    private int engineCapacity; // in cc
    private boolean hasABS;
    private boolean hasTractionControl;
    private String licenseRequirement; // Type of license required (A, A1, A2, etc.)

    public Motorcycle() {
        super();
    }

    public Motorcycle(String vehicleId, String make, String model, Year year, String licensePlate,
                      String color, BigDecimal dailyRate, String imageUrl, String currentLocation,
                      int seatingCapacity, String fuelType, String transmissionType,
                      LocalDate lastMaintenanceDate, int mileage, String category, int engineCapacity,
                      boolean hasABS, boolean hasTractionControl, String licenseRequirement) {
        super(vehicleId, make, model, year, licensePlate, color, dailyRate, imageUrl,
                currentLocation, seatingCapacity, fuelType, transmissionType, lastMaintenanceDate, mileage);
        this.category = category;
        this.engineCapacity = engineCapacity;
        this.hasABS = hasABS;
        this.hasTractionControl = hasTractionControl;
        this.licenseRequirement = licenseRequirement;
    }

    @Override
    public String getVehicleType() {
        return "MOTORCYCLE";
    }

    @Override
    public String toFileString() {
        // Add motorcycle-specific fields to the base vehicle file string
        return super.toFileString() + "|" +
                category + "|" +
                engineCapacity + "|" +
                hasABS + "|" +
                hasTractionControl + "|" +
                licenseRequirement;
    }

    // Static method to parse a Motorcycle from a file string
    public static Motorcycle fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 21) {
            throw new IllegalArgumentException("Invalid file string format for Motorcycle");
        }

        // Parse the base Vehicle fields
        Motorcycle motorcycle = (Motorcycle) Vehicle.fromFileString(fileString);

        // Parse Motorcycle-specific fields
        motorcycle.setCategory(parts[16]);
        motorcycle.setEngineCapacity(Integer.parseInt(parts[17]));
        motorcycle.setHasABS(Boolean.parseBoolean(parts[18]));
        motorcycle.setHasTractionControl(Boolean.parseBoolean(parts[19]));
        motorcycle.setLicenseRequirement(parts[20]);

        return motorcycle;
    }

    // Calculate risk factor based on engine capacity and safety features
    public int calculateRiskFactor() {
        int risk = 0;

        // Higher cc means higher risk
        if (engineCapacity > 1000) {
            risk += 3;
        } else if (engineCapacity > 600) {
            risk += 2;
        } else if (engineCapacity > 250) {
            risk += 1;
        }

        // Safety features reduce risk
        if (hasABS) {
            risk -= 1;
        }
        if (hasTractionControl) {
            risk -= 1;
        }

        // Minimum risk is 0
        return Math.max(0, risk);
    }

    // Getters and Setters
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getEngineCapacity() {
        return engineCapacity;
    }

    public void setEngineCapacity(int engineCapacity) {
        this.engineCapacity = engineCapacity;
    }

    public boolean isHasABS() {
        return hasABS;
    }

    public void setHasABS(boolean hasABS) {
        this.hasABS = hasABS;
    }

    public boolean isHasTractionControl() {
        return hasTractionControl;
    }

    public void setHasTractionControl(boolean hasTractionControl) {
        this.hasTractionControl = hasTractionControl;
    }

    public String getLicenseRequirement() {
        return licenseRequirement;
    }

    public void setLicenseRequirement(String licenseRequirement) {
        this.licenseRequirement = licenseRequirement;
    }

    @Override
    public String toString() {
        return "Motorcycle{" +
                "vehicleId='" + getVehicleId() + '\'' +
                ", make='" + getMake() + '\'' +
                ", model='" + getModel() + '\'' +
                ", year=" + getYear() +
                ", category='" + category + '\'' +
                ", engineCapacity=" + engineCapacity + "cc" +
                ", dailyRate=" + getDailyRate() +
                ", available=" + isAvailable() +
                '}';
    }
}