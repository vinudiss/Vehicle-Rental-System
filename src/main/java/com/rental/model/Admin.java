package com.rental.model;

import java.time.LocalDateTime;

/**
 * Admin class extends User
 * Represents a system administrator with elevated privileges
 */
public class Admin extends User {
    private String position;  // Role/position within the company
    private String department;
    private LocalDateTime lastSystemAccess;

    public Admin() {
        super();
    }

    public Admin(String userId, String username, String password, String salt, String fullName,
                 String email, String phone, String position, String department) {
        super(userId, username, password, salt, fullName, email, phone);
        this.position = position;
        this.department = department;
    }

    @Override
    public String getUserType() {
        return "ADMIN";
    }

    @Override
    public String toFileString() {
        // Add admin-specific fields to the base user file string
        return super.toFileString() + "|" +
                position + "|" +
                department + "|" +
                (lastSystemAccess != null ? lastSystemAccess.toString() : "");
    }

    // Static method to parse an Admin from a file string
    public static Admin fromFileString(String fileString) {
        String[] parts = fileString.split("\\|");
        if (parts.length < 14) {
            throw new IllegalArgumentException("Invalid file string format for Admin");
        }

        // Parse the base User fields
        Admin admin = (Admin) User.fromFileString(fileString);

        // Parse Admin-specific fields
        admin.setPosition(parts[12]);
        admin.setDepartment(parts[13]);

        if (parts.length > 14 && !parts[14].isEmpty()) {
            admin.setLastSystemAccess(LocalDateTime.parse(parts[14]));
        }

        return admin;
    }

    // Record system access
    public void recordSystemAccess() {
        this.lastSystemAccess = LocalDateTime.now();
    }

    // Getters and Setters
    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public LocalDateTime getLastSystemAccess() {
        return lastSystemAccess;
    }

    public void setLastSystemAccess(LocalDateTime lastSystemAccess) {
        this.lastSystemAccess = lastSystemAccess;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "userId='" + getUserId() + '\'' +
                ", username='" + getUsername() + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", position='" + position + '\'' +
                ", department='" + department + '\'' +
                '}';
    }
}