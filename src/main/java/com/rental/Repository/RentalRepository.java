package com.rental.vehiclerentalsystem2_0.repository;


import com.rental.vehiclerentalsystem2_0.model.Rental;
import com.rental.vehiclerentalsystem2_0.model.Customer;
import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface RentalRepository extends JpaRepository<Rental, Long> {

    List<Rental> findByVehicle(Vehicle vehicle);

    List<Rental> findByCustomer(Customer customer);

    List<Rental> findByStatus(Rental.RentalStatus status);

    List<Rental> findByEndDateBefore(LocalDateTime date);
}