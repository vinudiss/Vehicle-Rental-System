package com.rental.vehiclerentalsystem2_0.dto;

import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class VehicleDTO {

    private Long id;

    @NotBlank(message = "Make is required")
    private String make;

    @NotBlank(message = "Model is required")
    private String model;

    @NotNull(message = "Year is required")
    @Min(value = 1900, message = "Year must be valid")
    private Integer year;

    @NotBlank(message = "License plate is required")
    @Size(min = 2, max = 15, message = "License plate must be between 2 and 15 characters")
    private String licensePlate;

    @NotNull(message = "Vehicle type is required")
    private Vehicle.VehicleType type;

    @NotNull(message = "Daily rate is required")
    @Min(value = 0, message = "Daily rate must be positive")
    private BigDecimal dailyRate;

    private boolean available = true;

    @NotNull(message = "Vehicle condition is required")
    private Vehicle.VehicleCondition condition = Vehicle.VehicleCondition.GOOD;

    private String imageUrl;
}
