package com.rental.vehiclerentalsystem2_0.repository;

import com.rental.vehiclerentalsystem2_0.model.Payment;
import com.rental.vehiclerentalsystem2_0.model.Rental;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    List<Payment> findByRental(Rental rental);

    Optional<Payment> findByTransactionId(String transactionId);

    List<Payment> findByStatus(Payment.PaymentStatus status);
}
