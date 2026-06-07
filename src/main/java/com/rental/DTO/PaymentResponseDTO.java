package com.rental.vehiclerentalsystem2_0.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentResponseDTO {

    private Long id;
    private Long rentalId;
    private BigDecimal amount;
    private String paymentMethod;
    private String status; // SUCCESS, PENDING, FAILED
    private String transactionId;
    private String message;
    private LocalDateTime paymentDate;
    private String redirectUrl; // For external payment methods like PayPal

    // For card payments - show last 4 digits
    private String cardLast4;

    public static PaymentResponseDTO success(Long id, Long rentalId, BigDecimal amount, String paymentMethod, String transactionId) {
        PaymentResponseDTO response = new PaymentResponseDTO();
        response.setId(id);
        response.setRentalId(rentalId);
        response.setAmount(amount);
        response.setPaymentMethod(paymentMethod);
        response.setStatus("SUCCESS");
        response.setTransactionId(transactionId);
        response.setMessage("Payment processed successfully");
        response.setPaymentDate(LocalDateTime.now());
        return response;
    }

    public static PaymentResponseDTO pending(Long id, Long rentalId, BigDecimal amount, String paymentMethod, String redirectUrl) {
        PaymentResponseDTO response = new PaymentResponseDTO();
        response.setId(id);
        response.setRentalId(rentalId);
        response.setAmount(amount);
        response.setPaymentMethod(paymentMethod);
        response.setStatus("PENDING");
        response.setMessage("Payment is being processed");
        response.setPaymentDate(LocalDateTime.now());
        response.setRedirectUrl(redirectUrl);
        return response;
    }

    public static PaymentResponseDTO failed(Long rentalId, BigDecimal amount, String paymentMethod, String message) {
        PaymentResponseDTO response = new PaymentResponseDTO();
        response.setRentalId(rentalId);
        response.setAmount(amount);
        response.setPaymentMethod(paymentMethod);
        response.setStatus("FAILED");
        response.setMessage(message);
        response.setPaymentDate(LocalDateTime.now());
        return response;
    }
}
