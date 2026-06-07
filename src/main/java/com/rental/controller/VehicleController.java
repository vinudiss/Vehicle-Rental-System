package com.rental.vehiclerentalsystem2_0.controller;


import com.rental.vehiclerentalsystem2_0.dto.VehicleDTO;
import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import com.rental.vehiclerentalsystem2_0.service.VehicleService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/vehicles")
public class VehicleController {

    private final VehicleService vehicleService;

    @Autowired
    public VehicleController(VehicleService vehicleService) {
        this.vehicleService = vehicleService;
    }

    @GetMapping
    public ResponseEntity<List<VehicleDTO>> getAllVehicles() {
        return ResponseEntity.ok(vehicleService.getAllVehicles());
    }

    @GetMapping("/sorted/availability")
    public ResponseEntity<List<VehicleDTO>> getAllVehiclesSortedByAvailability() {
        return ResponseEntity.ok(vehicleService.getAllVehiclesSortedByAvailability());
    }

    @GetMapping("/sorted/price")
    public ResponseEntity<List<VehicleDTO>> getAllVehiclesSortedByPrice(
            @RequestParam(defaultValue = "true") boolean ascending) {
        return ResponseEntity.ok(vehicleService.getAllVehiclesSortedByPrice(ascending));
    }

    @GetMapping("/sorted/condition")
    public ResponseEntity<List<VehicleDTO>> getAllVehiclesSortedByCondition(
            @RequestParam(defaultValue = "true") boolean bestFirst) {
        return ResponseEntity.ok(vehicleService.getAllVehiclesSortedByCondition(bestFirst));
    }

    @GetMapping("/{id}")
    public ResponseEntity<VehicleDTO> getVehicleById(@PathVariable Long id) {
        return ResponseEntity.ok(vehicleService.getVehicleById(id));
    }

    @GetMapping("/available")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehicles() {
        return ResponseEntity.ok(vehicleService.getAvailableVehicles());
    }

    @GetMapping("/available/sorted/price")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehiclesSortedByPrice(
            @RequestParam(defaultValue = "true") boolean ascending) {
        return ResponseEntity.ok(vehicleService.getAvailableVehiclesSortedByPrice(ascending));
    }

    @GetMapping("/available/sorted/condition")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehiclesSortedByCondition(
            @RequestParam(defaultValue = "true") boolean bestFirst) {
        return ResponseEntity.ok(vehicleService.getAvailableVehiclesSortedByCondition(bestFirst));
    }

    @GetMapping("/available-for-period")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehiclesForPeriod(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate) {
        return ResponseEntity.ok(vehicleService.getAvailableVehiclesForPeriod(startDate, endDate));
    }

    @GetMapping("/available-for-period/sorted/price")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehiclesForPeriodSortedByPrice(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(defaultValue = "true") boolean ascending) {
        return ResponseEntity.ok(vehicleService.getAvailableVehiclesForPeriodSortedByPrice(startDate, endDate, ascending));
    }

    @GetMapping("/available-for-period/sorted/condition")
    public ResponseEntity<List<VehicleDTO>> getAvailableVehiclesForPeriodSortedByCondition(
            @RequestParam("startDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam("endDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            @RequestParam(defaultValue = "true") boolean bestFirst) {
        return ResponseEntity.ok(vehicleService.getAvailableVehiclesForPeriodSortedByCondition(startDate, endDate, bestFirst));
    }

    @PostMapping
    public ResponseEntity<VehicleDTO> createVehicle(@Valid @RequestBody VehicleDTO vehicleDTO) {
        return new ResponseEntity<>(vehicleService.createVehicle(vehicleDTO), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<VehicleDTO> updateVehicle(
            @PathVariable Long id,
            @Valid @RequestBody VehicleDTO vehicleDTO) {
        return ResponseEntity.ok(vehicleService.updateVehicle(id, vehicleDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVehicle(@PathVariable Long id) {
        vehicleService.deleteVehicle(id);
        return ResponseEntity.noContent().build();
    }
}
