package com.rental.vehiclerentalsystem2_0.service;

import com.rental.vehiclerentalsystem2_0.dto.RentalDTO;
import com.rental.vehiclerentalsystem2_0.exception.ResourceNotFoundException;
import com.rental.vehiclerentalsystem2_0.exception.BusinessException;
import com.rental.vehiclerentalsystem2_0.model.Customer;
import com.rental.vehiclerentalsystem2_0.model.Rental;
import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import com.rental.vehiclerentalsystem2_0.repository.CustomerRepository;
import com.rental.vehiclerentalsystem2_0.repository.RentalRepository;
import com.rental.vehiclerentalsystem2_0.repository.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RentalService {

    private final RentalRepository rentalRepository;
    private final VehicleRepository vehicleRepository;
    private final CustomerRepository customerRepository;

    @Autowired
    public RentalService(
            RentalRepository rentalRepository,
            VehicleRepository vehicleRepository,
            CustomerRepository customerRepository) {
        this.rentalRepository = rentalRepository;
        this.vehicleRepository = vehicleRepository;
        this.customerRepository = customerRepository;
    }

    @Transactional(readOnly = true)
    public List<RentalDTO> getAllRentals() {
        return rentalRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public RentalDTO getRentalById(Long id) {
        Rental rental = rentalRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Rental not found with id: " + id));
        return convertToDTO(rental);
    }

    @Transactional(readOnly = true)
    public List<RentalDTO> getRentalsByCustomerId(Long customerId) {
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + customerId));

        return rentalRepository.findByCustomer(customer).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional
    public RentalDTO createRental(RentalDTO rentalDTO) {
        // Validate dates
        if (rentalDTO.getEndDate().isBefore(rentalDTO.getStartDate())) {
            throw new BusinessException("End date cannot be before start date");
        }

        if (rentalDTO.getStartDate().isBefore(LocalDateTime.now())) {
            throw new BusinessException("Start date cannot be in the past");
        }

        // Find vehicle and customer
        Vehicle vehicle = vehicleRepository.findById(rentalDTO.getVehicleId())
                .orElseThrow(() -> new ResourceNotFoundException("Vehicle not found with id: " + rentalDTO.getVehicleId()));

        Customer customer = customerRepository.findById(rentalDTO.getCustomerId())
                .orElseThrow(() -> new ResourceNotFoundException("Customer not found with id: " + rentalDTO.getCustomerId()));

        // Check if vehicle is available
        if (!vehicle.isAvailable()) {
            throw new BusinessException("Vehicle is not available for rental");
        }

        // Check if vehicle is available for the requested dates (no overlapping rentals)
        List<Vehicle> availableVehicles = vehicleRepository.findAvailableVehicles(
                rentalDTO.getStartDate(), rentalDTO.getEndDate());

        if (!availableVehicles.contains(vehicle)) {
            throw new BusinessException("Vehicle is already booked for the selected dates");
        }

        // Calculate total cost
        long days = Duration.between(rentalDTO.getStartDate(), rentalDTO.getEndDate()).toDays();
        if (days < 1) days = 1; // Minimum 1 day rental

        BigDecimal totalCost = vehicle.getDailyRate().multiply(BigDecimal.valueOf(days));

        // Create rental entity
        Rental rental = new Rental();
        rental.setVehicle(vehicle);
        rental.setCustomer(customer);
        rental.setStartDate(rentalDTO.getStartDate());
        rental.setEndDate(rentalDTO.getEndDate());
        rental.setTotalCost(totalCost);
        rental.setStatus(Rental.RentalStatus.RESERVED);

        // Update vehicle availability
        vehicle.setAvailable(false);
        vehicleRepository.save(vehicle);

        // Save rental
        Rental savedRental = rentalRepository.save(rental);
        return convertToDTO(savedRental);
    }

    @Transactional
    public RentalDTO updateRentalStatus(Long id, Rental.RentalStatus status) {
        Rental rental = rentalRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Rental not found with id: " + id));

        rental.setStatus(status);

        // If rental is completed or cancelled, make the vehicle available
        if (status == Rental.RentalStatus.COMPLETED || status == Rental.RentalStatus.CANCELLED) {
            Vehicle vehicle = rental.getVehicle();
            vehicle.setAvailable(true);
            vehicleRepository.save(vehicle);
        }

        // If rental is active, make the vehicle unavailable
        if (status == Rental.RentalStatus.ACTIVE) {
            Vehicle vehicle = rental.getVehicle();
            vehicle.setAvailable(false);
            vehicleRepository.save(vehicle);
        }

        Rental updatedRental = rentalRepository.save(rental);
        return convertToDTO(updatedRental);
    }

    @Transactional
    public void deleteRental(Long id) {
        Rental rental = rentalRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Rental not found with id: " + id));

        // If the rental is deleted, make the vehicle available again
        Vehicle vehicle = rental.getVehicle();
        vehicle.setAvailable(true);
        vehicleRepository.save(vehicle);

        rentalRepository.deleteById(id);
    }

    // Helper method to convert between DTOs and Entities
    private RentalDTO convertToDTO(Rental rental) {
        RentalDTO rentalDTO = new RentalDTO();
        rentalDTO.setId(rental.getId());
        rentalDTO.setVehicleId(rental.getVehicle().getId());
        rentalDTO.setCustomerId(rental.getCustomer().getId());
        rentalDTO.setStartDate(rental.getStartDate());
        rentalDTO.setEndDate(rental.getEndDate());
        rentalDTO.setTotalCost(rental.getTotalCost());
        rentalDTO.setStatus(rental.getStatus());

        // Add vehicle and customer details for display
        Vehicle vehicle = rental.getVehicle();
        Customer customer = rental.getCustomer();

        rentalDTO.setVehicleDescription(vehicle.getYear() + " " + vehicle.getMake() + " " + vehicle.getModel());
        rentalDTO.setCustomerName(customer.getFirstName() + " " + customer.getLastName());

        return rentalDTO;
    }
}