package com.rental.vehiclerentalsystem2_0.dto;


import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class PaymentDTO {

    private Long id;

    @NotNull(message = "Rental ID is required")
    private Long rentalId;

    @NotNull(message = "Amount is required")
    @Min(value = 0, message = "Amount must be positive")
    private BigDecimal amount;

    @NotNull(message = "Payment method is required")
    @NotBlank(message = "Payment method is required")
    private String paymentMethod; // CREDIT_CARD, PAYPAL, GOOGLE_PAY, APPLE_PAY

    // Credit Card specific fields
    private String cardNumber;
    private String cardHolderName;
    private String expiryDate;
    private String cvv;

    // PayPal specific fields
    private String paypalEmail;

    // Transaction reference for external payment methods
    private String transactionReference;

    // Additional fields
    private String billingAddress;
    private String billingZip;
    private String billingCity;
    private String billingCountry;

    private boolean savePaymentMethod;
}