package com.rental.vehiclerentalsystem2_0.controller;


import com.rental.vehiclerentalsystem2_0.dto.RentalDTO;
import com.rental.vehiclerentalsystem2_0.model.Rental;
import com.rental.vehiclerentalsystem2_0.service.RentalService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/rentals")
public class RentalController {

    private final RentalService rentalService;

    @Autowired
    public RentalController(RentalService rentalService) {
        this.rentalService = rentalService;
    }

    @GetMapping
    public ResponseEntity<List<RentalDTO>> getAllRentals() {
        return ResponseEntity.ok(rentalService.getAllRentals());
    }

    @GetMapping("/{id}")
    public ResponseEntity<RentalDTO> getRentalById(@PathVariable Long id) {
        return ResponseEntity.ok(rentalService.getRentalById(id));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<RentalDTO>> getRentalsByCustomerId(@PathVariable Long customerId) {
        return ResponseEntity.ok(rentalService.getRentalsByCustomerId(customerId));
    }

    @PostMapping
    public ResponseEntity<RentalDTO> createRental(@Valid @RequestBody RentalDTO rentalDTO) {
        return new ResponseEntity<>(rentalService.createRental(rentalDTO), HttpStatus.CREATED);
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<RentalDTO> updateRentalStatus(
            @PathVariable Long id,
            @RequestParam Rental.RentalStatus status) {
        return ResponseEntity.ok(rentalService.updateRentalStatus(id, status));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRental(@PathVariable Long id) {
        rentalService.deleteRental(id);
        return ResponseEntity.noContent().build();
    }
}