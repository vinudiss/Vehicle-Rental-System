package com.rental.vehiclerentalsystem2_0.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "rental_id", nullable = false)
    private Rental rental;

    @Column(nullable = false)
    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentMethod paymentMethod;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentStatus status;

    @Column(unique = true)
    private String transactionId;

    private String cardLast4;

    private LocalDateTime paymentDate;

    @Column(columnDefinition = "TEXT")
    private String paymentDetails;

    // Used for external payment methods like PayPal
    private String redirectUrl;

    // Error message if payment failed
    private String errorMessage;

    // Enum for payment methods
    public enum PaymentMethod {
        CREDIT_CARD, PAYPAL, GOOGLE_PAY, APPLE_PAY
    }

    // Enum for payment status
    public enum PaymentStatus {
        PENDING, SUCCESS, FAILED, REFUNDED
    }
}