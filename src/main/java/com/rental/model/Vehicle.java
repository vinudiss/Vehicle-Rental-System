package com.rental.vehiclerentalsystem2_0.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "vehicles")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String make;

    @Column(nullable = false)
    private String model;

    @Column(nullable = false)
    private int year;

    @Column(nullable = false)
    private String licensePlate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private VehicleType type;

    @Column(nullable = false)
    private BigDecimal dailyRate;

    @Column(nullable = false)
    private boolean available = true;

    @Enumerated(EnumType.STRING)
    @Column(name = "vehicle_condition", nullable = false)
    private VehicleCondition vehicleCondition = VehicleCondition.GOOD;

    @Column(name = "image_url")
    private String imageUrl;

    public VehicleCondition getCondition() {
        return vehicleCondition;
    }

    // Enum for vehicle types
    public enum VehicleType {
        SEDAN, SUV, TRUCK, VAN, LUXURY, CAR, BIKE, TUKTUK
    }

    // Enum for vehicle condition
    public enum VehicleCondition {
        POOR(1),
        FAIR(2),
        GOOD(3),
        EXCELLENT(4),
        NEW(5);

        private final int value;

        VehicleCondition(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }
}
    
        
               
      

       
       
      
     

   
  

   
       


   
