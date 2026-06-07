package com.rental.vehiclerentalsystem2_0.repository;


import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {

    List<Vehicle> findByAvailableTrue();

    List<Vehicle> findByType(Vehicle.VehicleType type);

    @Query("SELECT v FROM Vehicle v WHERE v.id NOT IN " +
            "(SELECT r.vehicle.id FROM Rental r WHERE " +
            "r.status IN ('RESERVED', 'ACTIVE') AND " +
            "((r.startDate <= ?2 AND r.endDate >= ?1) OR " +
            "(r.startDate >= ?1 AND r.startDate <= ?2)))")
    List<Vehicle> findAvailableVehicles(LocalDateTime startDate, LocalDateTime endDate);
}
