package com.rental.vehiclerentalsystem2_0.service;

import com.rental.vehiclerentalsystem2_0.dto.VehicleDTO;
import com.rental.vehiclerentalsystem2_0.exception.ResourceNotFoundException;
import com.rental.vehiclerentalsystem2_0.model.Vehicle;
import com.rental.vehiclerentalsystem2_0.repository.VehicleRepository;
import com.rental.vehiclerentalsystem2_0.util.VehicleSorter;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class VehicleService {

    private final VehicleRepository vehicleRepository;
    private final ImageService imageService;

    @Autowired
    public VehicleService(VehicleRepository vehicleRepository, ImageService imageService) {
        this.vehicleRepository = vehicleRepository;
        this.imageService = imageService;
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAllVehicles() {
        return vehicleRepository.findAll().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAllVehiclesSortedByAvailability() {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findAll());
        VehicleSorter.sortByAvailability(vehicles);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAllVehiclesSortedByPrice(boolean ascending) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findAll());
        VehicleSorter.sortByPrice(vehicles, ascending);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAllVehiclesSortedByCondition(boolean bestFirst) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findAll());
        VehicleSorter.sortByCondition(vehicles, bestFirst);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public VehicleDTO getVehicleById(Long id) {
        Vehicle vehicle = vehicleRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vehicle not found with id: " + id));
        return convertToDTO(vehicle);
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehicles() {
        return vehicleRepository.findByAvailableTrue().stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehiclesSortedByPrice(boolean ascending) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findByAvailableTrue());
        VehicleSorter.sortByPrice(vehicles, ascending);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehiclesSortedByCondition(boolean bestFirst) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findByAvailableTrue());
        VehicleSorter.sortByCondition(vehicles, bestFirst);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehiclesForPeriod(LocalDateTime startDate, LocalDateTime endDate) {
        return vehicleRepository.findAvailableVehicles(startDate, endDate).stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehiclesForPeriodSortedByPrice(
            LocalDateTime startDate, LocalDateTime endDate, boolean ascending) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findAvailableVehicles(startDate, endDate));
        VehicleSorter.sortByPrice(vehicles, ascending);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<VehicleDTO> getAvailableVehiclesForPeriodSortedByCondition(
            LocalDateTime startDate, LocalDateTime endDate, boolean bestFirst) {
        List<Vehicle> vehicles = new ArrayList<>(vehicleRepository.findAvailableVehicles(startDate, endDate));
        VehicleSorter.sortByCondition(vehicles, bestFirst);
        return vehicles.stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Transactional
    public VehicleDTO createVehicle(VehicleDTO vehicleDTO) {
        // If no image URL provided, generate one based on vehicle type
        if (vehicleDTO.getImageUrl() == null || vehicleDTO.getImageUrl().trim().isEmpty()) {
            vehicleDTO.setImageUrl(imageService.getRandomImageUrlForType(vehicleDTO.getType()));
        }

        Vehicle vehicle = convertToEntity(vehicleDTO);
        Vehicle savedVehicle = vehicleRepository.save(vehicle);
        return convertToDTO(savedVehicle);
    }

    @Transactional
    public VehicleDTO updateVehicle(Long id, VehicleDTO vehicleDTO) {
        Vehicle vehicle = vehicleRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Vehicle not found with id: " + id));

        // Don't update the ID
        vehicleDTO.setId(id);

        // Keep the current image URL if a new one is not provided
        if (vehicleDTO.getImageUrl() == null || vehicleDTO.getImageUrl().trim().isEmpty()) {
            vehicleDTO.setImageUrl(vehicle.getImageUrl());

            // If the current vehicle doesn't have an image and the type is changing,
            // generate a new image URL based on the new type
            if ((vehicleDTO.getImageUrl() == null || vehicleDTO.getImageUrl().trim().isEmpty())
                    && vehicleDTO.getType() != vehicle.getType()) {
                vehicleDTO.setImageUrl(imageService.getRandomImageUrlForType(vehicleDTO.getType()));
            }
        }

        BeanUtils.copyProperties(vehicleDTO, vehicle, "id");

        Vehicle updatedVehicle = vehicleRepository.save(vehicle);
        return convertToDTO(updatedVehicle);
    }

    @Transactional
    public void updateAllVehiclesWithImages() {
        List<Vehicle> vehicles = vehicleRepository.findAll();
        for (Vehicle vehicle : vehicles) {
            if (vehicle.getImageUrl() == null || vehicle.getImageUrl().trim().isEmpty()) {
                vehicle.setImageUrl(imageService.getRandomImageUrlForType(vehicle.getType()));
                vehicleRepository.save(vehicle);
            }
        }
    }

    @Transactional
    public void deleteVehicle(Long id) {
        if (!vehicleRepository.existsById(id)) {
            throw new ResourceNotFoundException("Vehicle not found with id: " + id);
        }
        vehicleRepository.deleteById(id);
    }

    // Helper methods to convert between DTOs and Entities
    private VehicleDTO convertToDTO(Vehicle vehicle) {
        VehicleDTO vehicleDTO = new VehicleDTO();
        BeanUtils.copyProperties(vehicle, vehicleDTO);
        vehicleDTO.setCondition(vehicle.getVehicleCondition());
        return vehicleDTO;
    }

    private Vehicle convertToEntity(VehicleDTO vehicleDTO) {
        Vehicle vehicle = new Vehicle();
        BeanUtils.copyProperties(vehicleDTO, vehicle);
        vehicle.setVehicleCondition(vehicleDTO.getCondition());
        return vehicle;
    }
}
