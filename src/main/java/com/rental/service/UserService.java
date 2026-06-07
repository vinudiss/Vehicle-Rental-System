package com.rental.service;

import com.rental.model.Admin;
import com.rental.model.Customer;
import com.rental.model.User;
import com.rental.util.IdGenerator;
import com.rental.util.PasswordUtil;
import com.rental.util.ValidationUtil;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Service class that handles user-related business logic
 * Manages user data persistence using file operations
 */
public class UserService {

    private static final String DATA_DIRECTORY = "data";
    private static final String USERS_FILE = DATA_DIRECTORY + File.separator + "users.txt";

    private List<User> users;

    public UserService() {
        this.users = new ArrayList<>();
        loadUsers();
    }

    /**
     * Load all users from the file
     */
    private void loadUsers() {
        File dataDir = new File(DATA_DIRECTORY);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        Path path = Paths.get(USERS_FILE);
        if (!Files.exists(path)) {
            // Create the file if it doesn't exist
            try {
                Files.createFile(path);
                // Create default admin if file is new
                createDefaultAdmin();
            } catch (IOException e) {
                System.err.println("Error creating users file: " + e.getMessage());
            }
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    try {
                        User user = User.fromFileString(line);
                        users.add(user);
                    } catch (Exception e) {
                        System.err.println("Error parsing user: " + e.getMessage());
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading users: " + e.getMessage());
        }
    }

    /**
     * Save all users to the file
     */
    private void saveUsers() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
            for (User user : users) {
                writer.write(user.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
        }
    }

    /**
     * Create a default admin account if no users exist
     */
    private void createDefaultAdmin() {
        String userId = IdGenerator.generateUserId();
        String username = "admin";
        String password = "Admin123";
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(password, salt);

        Admin admin = new Admin(userId, username, hashedPassword, salt, "System Administrator",
                "admin@vehiclerental.com", "1234567890", "System Admin", "IT");

        users.add(admin);
        saveUsers();
    }

    /**
     * Register a new customer user
     *
     * @param username The username
     * @param password The plain text password
     * @param fullName The user's full name
     * @param email The user's email
     * @param phone The user's phone number
     * @param driverLicense The user's driver license number
     * @return The newly created user object
     * @throws IllegalArgumentException if validation fails
     */
    public Customer registerCustomer(String username, String password, String fullName,
                                     String email, String phone, String driverLicense) {

        // Validate input
        validateUserInput(username, password, fullName, email, phone);

        // Check if username already exists
        if (getUserByUsername(username).isPresent()) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Generate unique ID and salt
        String userId = IdGenerator.generateUserId();
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(password, salt);

        // Create new customer
        Customer customer = new Customer(userId, username, hashedPassword, salt, fullName, email, phone, driverLicense, null);

        // Add to list and save
        users.add(customer);
        saveUsers();

        return customer;
    }

    /**
     * Register a new admin user (should only be allowed by existing admins)
     *
     * @param username The username
     * @param password The plain text password
     * @param fullName The user's full name
     * @param email The user's email
     * @param phone The user's phone number
     * @param position The admin's position
     * @param department The admin's department
     * @return The newly created admin object
     * @throws IllegalArgumentException if validation fails
     */
    public Admin registerAdmin(String username, String password, String fullName,
                               String email, String phone, String position, String department) {

        // Validate input
        validateUserInput(username, password, fullName, email, phone);

        // Check if username already exists
        if (getUserByUsername(username).isPresent()) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Generate unique ID and salt
        String userId = IdGenerator.generateUserId();
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(password, salt);

        // Create new admin
        Admin admin = new Admin(userId, username, hashedPassword, salt, fullName, email, phone, position, department);

        // Add to list and save
        users.add(admin);
        saveUsers();

        return admin;
    }

    /**
     * Validate user input data
     */
    private void validateUserInput(String username, String password, String fullName, String email, String phone) {
        if (!ValidationUtil.isValidUsername(username)) {
            throw new IllegalArgumentException("Invalid username format. Username must be 4-20 characters and contain only letters, numbers, underscores, or hyphens.");
        }

        if (!PasswordUtil.isValidPassword(password)) {
            throw new IllegalArgumentException("Invalid password. Password must be at least 8 characters with at least one uppercase letter, one lowercase letter, and one digit.");
        }

        if (!ValidationUtil.isValidName(fullName)) {
            throw new IllegalArgumentException("Invalid name format");
        }

        if (!ValidationUtil.isValidEmail(email)) {
            throw new IllegalArgumentException("Invalid email format");
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            throw new IllegalArgumentException("Invalid phone number format");
        }
    }

    /**
     * Authenticate a user with username and password
     *
     * @param username The username
     * @param password The plain text password
     * @return Optional containing the user if authentication successful, empty otherwise
     */
    public Optional<User> authenticateUser(String username, String password) {
        Optional<User> userOpt = getUserByUsername(username);

        if (!userOpt.isPresent()) {
            // User not found
            return Optional.empty();
        }

        User user = userOpt.get();

        // Check if account is locked
        if (user.isLocked()) {
            return Optional.empty();
        }

        // Verify password
        if (PasswordUtil.verifyPassword(password, user.getPassword(), user.getSalt())) {
            // Password is correct, reset failed attempts and record login
            user.resetFailedLoginAttempts();
            user.recordSuccessfulLogin();
            saveUsers();
            return Optional.of(user);
        } else {
            // Password is incorrect, increment failed attempts
            user.incrementFailedLoginAttempts();
            saveUsers();
            return Optional.empty();
        }
    }

    /**
     * Get a user by their unique ID
     *
     * @param userId The user ID to search for
     * @return Optional containing the user if found, empty otherwise
     */
    public Optional<User> getUserById(String userId) {
        return users.stream()
                .filter(user -> user.getUserId().equals(userId))
                .findFirst();
    }

    /**
     * Get a user by their username
     *
     * @param username The username to search for
     * @return Optional containing the user if found, empty otherwise
     */
    public Optional<User> getUserByUsername(String username) {
        return users.stream()
                .filter(user -> user.getUsername().equalsIgnoreCase(username))
                .findFirst();
    }

    /**
     * Get a user by their email
     *
     * @param email The email to search for
     * @return Optional containing the user if found, empty otherwise
     */
    public Optional<User> getUserByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst();
    }

    /**
     * Get all users
     *
     * @return List of all users
     */
    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }

    /**
     * Get all customers
     *
     * @return List of all customers
     */
    public List<Customer> getAllCustomers() {
        return users.stream()
                .filter(user -> user instanceof Customer)
                .map(user -> (Customer) user)
                .collect(Collectors.toList());
    }

    /**
     * Get all admins
     *
     * @return List of all admins
     */
    public List<Admin> getAllAdmins() {
        return users.stream()
                .filter(user -> user instanceof Admin)
                .map(user -> (Admin) user)
                .collect(Collectors.toList());
    }

    /**
     * Update user details
     *
     * @param userId The ID of the user to update
     * @param fullName The new full name (or null to keep current)
     * @param email The new email (or null to keep current)
     * @param phone The new phone (or null to keep current)
     * @return Optional containing the updated user if found, empty otherwise
     */
    public Optional<User> updateUserDetails(String userId, String fullName, String email, String phone) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            return Optional.empty();
        }

        User user = userOpt.get();

        // Update fields if provided
        if (fullName != null && !fullName.trim().isEmpty()) {
            if (!ValidationUtil.isValidName(fullName)) {
                throw new IllegalArgumentException("Invalid name format");
            }
            user.setFullName(fullName);
        }

        if (email != null && !email.trim().isEmpty()) {
            if (!ValidationUtil.isValidEmail(email)) {
                throw new IllegalArgumentException("Invalid email format");
            }
            // Check if email is already in use by another user
            Optional<User> existingUser = getUserByEmail(email);
            if (existingUser.isPresent() && !existingUser.get().getUserId().equals(userId)) {
                throw new IllegalArgumentException("Email is already in use");
            }
            user.setEmail(email);
        }

        if (phone != null && !phone.trim().isEmpty()) {
            if (!ValidationUtil.isValidPhone(phone)) {
                throw new IllegalArgumentException("Invalid phone number format");
            }
            user.setPhone(phone);
        }

        saveUsers();
        return Optional.of(user);
    }

    /**
     * Update customer specific details
     *
     * @param userId The ID of the customer to update
     * @param driverLicense The new driver license number
     * @return Optional containing the updated customer if found, empty otherwise
     */
    public Optional<Customer> updateCustomerDetails(String userId, String driverLicense) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent() || !(userOpt.get() instanceof Customer)) {
            return Optional.empty();
        }

        Customer customer = (Customer) userOpt.get();

        // Update driver license if provided
        if (driverLicense != null && !driverLicense.trim().isEmpty()) {
            customer.setDriverLicense(driverLicense);
        }

        saveUsers();
        return Optional.of(customer);
    }

    /**
     * Update admin specific details
     *
     * @param userId The ID of the admin to update
     * @param position The new position
     * @param department The new department
     * @return Optional containing the updated admin if found, empty otherwise
     */
    public Optional<Admin> updateAdminDetails(String userId, String position, String department) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent() || !(userOpt.get() instanceof Admin)) {
            return Optional.empty();
        }

        Admin admin = (Admin) userOpt.get();

        // Update fields if provided
        if (position != null && !position.trim().isEmpty()) {
            admin.setPosition(position);
        }

        if (department != null && !department.trim().isEmpty()) {
            admin.setDepartment(department);
        }

        saveUsers();
        return Optional.of(admin);
    }

    /**
     * Change a user's password
     *
     * @param userId The ID of the user
     * @param currentPassword The current password for verification
     * @param newPassword The new password
     * @return true if password was changed successfully, false otherwise
     */
    public boolean changePassword(String userId, String currentPassword, String newPassword) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            return false;
        }

        User user = userOpt.get();

        // Verify current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword(), user.getSalt())) {
            return false;
        }

        // Validate new password
        if (!PasswordUtil.isValidPassword(newPassword)) {
            throw new IllegalArgumentException("Invalid password format");
        }

        // Update password
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(newPassword, salt);
        user.setPassword(hashedPassword);
        user.setSalt(salt);

        saveUsers();
        return true;
    }

    /**
     * Reset a user's password (admin function)
     *
     * @param userId The ID of the user
     * @return The new randomly generated password, or null if user not found
     */
    public String resetPassword(String userId) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            return null;
        }

        User user = userOpt.get();

        // Generate new random password
        String newPassword = PasswordUtil.generateRandomPassword();
        String salt = PasswordUtil.generateSalt();
        String hashedPassword = PasswordUtil.hashPassword(newPassword, salt);

        // Update user
        user.setPassword(hashedPassword);
        user.setSalt(salt);
        user.setLocked(false);
        user.resetFailedLoginAttempts();

        saveUsers();
        return newPassword;
    }

    /**
     * Unlock a user account
     *
     * @param userId The ID of the user
     * @return true if account was unlocked, false if user not found
     */
    public boolean unlockUserAccount(String userId) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            return false;
        }

        User user = userOpt.get();
        user.setLocked(false);
        user.resetFailedLoginAttempts();

        saveUsers();
        return true;
    }

    /**
     * Delete a user
     *
     * @param userId The ID of the user to delete
     * @return true if user was deleted, false if not found
     */
    public boolean deleteUser(String userId) {
        Optional<User> userOpt = getUserById(userId);
        if (!userOpt.isPresent()) {
            return false;
        }

        users.remove(userOpt.get());
        saveUsers();
        return true;
    }

    /**
     * Search for users by name, username, or email
     *
     * @param searchTerm The search term
     * @return List of matching users
     */
    public List<User> searchUsers(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return new ArrayList<>();
        }

        String term = searchTerm.toLowerCase();

        return users.stream()
                .filter(user ->
                        user.getUsername().toLowerCase().contains(term) ||
                                user.getFullName().toLowerCase().contains(term) ||
                                user.getEmail().toLowerCase().contains(term))
                .collect(Collectors.toList());
    }
}