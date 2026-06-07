package com.rental.vehiclerentalsystem2_0.dto;

import com.rental.vehiclerentalsystem2_0.model.Rental;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RentalDTO {

    private Long id;

    @NotNull(message = "Vehicle ID is required")
    private Long vehicleId;

    @NotNull(message = "Customer ID is required")
    private Long customerId;

    @NotNull(message = "Start date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime startDate;

    @NotNull(message = "End date is required")
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
    private LocalDateTime endDate;

    private BigDecimal totalCost;

    private Rental.RentalStatus status = Rental.RentalStatus.RESERVED;

    // Vehicle and customer details for display
    private String vehicleDescription;
    private String customerName;
}