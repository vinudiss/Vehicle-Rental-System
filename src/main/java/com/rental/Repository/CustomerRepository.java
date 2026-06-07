package com.rental.vehiclerentalsystem2_0.repository;


import com.rental.vehiclerentalsystem2_0.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Long> {

    Optional<Customer> findByEmail(String email);

    Optional<Customer> findByLicenseNumber(String licenseNumber);
}
