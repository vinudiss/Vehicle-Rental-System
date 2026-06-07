package com.rental.vehiclerentalsystem2_0.repository;

import com.rental.vehiclerentalsystem2_0.model.Rental;
import com.rental.vehiclerentalsystem2_0.model.Customer;
import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import com.rental.vehiclerentalsystem2_0.util.RentalLinkedList;
import org.springframework.stereotype.Component;
import org.springframework.context.annotation.Primary;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * Repository implementation that uses a custom LinkedList for rental records
 * This implementation wraps the JPA repository to leverage both technologies
 */
@Component
@Primary  // This will make Spring prefer this implementation over the standard JPA one
public class RentalLinkedListRepository {

    private static final Logger logger = LoggerFactory.getLogger(RentalLinkedListRepository.class);

    private final RentalRepository rentalJpaRepository;
    private RentalLinkedList rentalList;

    @Autowired
    public RentalLinkedListRepository(RentalRepository rentalJpaRepository) {
        this.rentalJpaRepository = rentalJpaRepository;
        this.rentalList = new RentalLinkedList();
    }

    /**
     * Initialize the linked list with existing data from the database
     */
    @PostConstruct
    public void init() {
        try {
            // Load existing rentals from the database into our linked list
            List<Rental> existingRentals = rentalJpaRepository.findAll();
            logger.info("Loaded {} rentals from database", existingRentals.size());

            for (Rental rental : existingRentals) {
                try {
                    rentalList.add(rental);
                } catch (Exception e) {
                    logger.error("Error adding rental with ID {} to linked list: {}",
                            rental.getId(), e.getMessage());
                }
            }
        } catch (Exception e) {
            logger.error("Error initializing rental linked list: {}", e.getMessage());
            // Initialize with empty list to allow application to start
            rentalList = new RentalLinkedList();
        }
    }

    /**
     * Find all rentals
     *
     * @return List of all rentals
     */
    public List<Rental> findAll() {
        List<Rental> result = new ArrayList<>();
        for (Rental rental : rentalList) {
            result.add(rental);
        }
        return result;
    }

    /**
     * Find a rental by its ID
     *
     * @param id The ID of the rental to find
     * @return Optional containing the rental if found
     */
    public Optional<Rental> findById(Long id) {
        Rental rental = rentalList.getById(id);
        return rental != null ? Optional.of(rental) : Optional.empty();
    }

    /**
     * Find rentals for a specific vehicle
     *
     * @param vehicle The vehicle to find rentals for
     * @return List of rentals for the vehicle
     */
    public List<Rental> findByVehicle(Vehicle vehicle) {
        List<Rental> result = new ArrayList<>();
        for (Rental rental : rentalList) {
            if (rental.getVehicle().equals(vehicle)) {
                result.add(rental);
            }
        }
        return result;
    }

    /**
     * Find rentals for a specific customer
     *
     * @param customer The customer to find rentals for
     * @return List of rentals for the customer
     */
    public List<Rental> findByCustomer(Customer customer) {
        List<Rental> result = new ArrayList<>();
        for (Rental rental : rentalList) {
            if (rental.getCustomer().equals(customer)) {
                result.add(rental);
            }
        }
        return result;
    }

    /**
     * Find rentals by status
     *
     * @param status The status to find rentals for
     * @return List of rentals with the specified status
     */
    public List<Rental> findByStatus(Rental.RentalStatus status) {
        List<Rental> result = new ArrayList<>();
        for (Rental rental : rentalList) {
            if (rental.getStatus().equals(status)) {
                result.add(rental);
            }
        }
        return result;
    }

    /**
     * Find rentals with end dates before a specific date
     *
     * @param date The date to compare against
     * @return List of rentals ending before the specified date
     */
    public List<Rental> findByEndDateBefore(LocalDateTime date) {
        List<Rental> result = new ArrayList<>();
        for (Rental rental : rentalList) {
            if (rental.getEndDate().isBefore(date)) {
                result.add(rental);
            }
        }
        return result;
    }

    /**
     * Save a rental record
     *
     * @param rental The rental to save
     * @return The saved rental
     */
    public Rental save(Rental rental) {
        // First save to the database to get an ID if it's new
        Rental savedRental = rentalJpaRepository.save(rental);

        // Then update our linked list
        if (rental.getId() == null) {
            // New rental
            rentalList.add(savedRental);
        } else {
            // Update existing rental
            rentalList.update(savedRental);
        }

        return savedRental;
    }

    /**
     * Delete a rental by its ID
     *
     * @param id The ID of the rental to delete
     */
    public void deleteById(Long id) {
        // Find the rental in our linked list
        Rental rental = rentalList.getById(id);
        if (rental != null) {
            // Remove from linked list
            rentalList.remove(rental);
            // Remove from database
            rentalJpaRepository.deleteById(id);
        }
    }

    /**
     * Check if a rental with the specified ID exists
     *
     * @param id The ID to check
     * @return true if a rental with the ID exists, false otherwise
     */
    public boolean existsById(Long id) {
        return rentalList.getById(id) != null;
    }
}