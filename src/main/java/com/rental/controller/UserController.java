package com.rental.controller;

import com.rental.model.Admin;
import com.rental.model.Customer;
import com.rental.model.User;
import com.rental.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

/**
 * Controller for handling user management operations
 */
@WebServlet("/users/*")
public class UserController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"ADMIN".equals(session.getAttribute("userType"))) {

            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Default action - list users
            listUsers(request, response);
            return;
        }

        // Parse the path to get the action and possibly an ID
        String[] pathParts = pathInfo.split("/");
        String action = pathParts.length > 1 ? pathParts[1] : "";
        String userId = pathParts.length > 2 ? pathParts[2] : "";

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "view":
                viewUser(request, response, userId);
                break;
            case "edit":
                showEditForm(request, response, userId);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "unlock":
                unlockUser(request, response, userId);
                break;
            case "reset-password":
                resetPassword(request, response, userId);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !"ADMIN".equals(session.getAttribute("userType"))) {

            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // No action specified
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No action specified");
            return;
        }

        // Parse the path to get the action and possibly an ID
        String[] pathParts = pathInfo.split("/");
        String action = pathParts.length > 1 ? pathParts[1] : "";
        String userId = pathParts.length > 2 ? pathParts[2] : "";

        switch (action) {
            case "add":
                addUser(request, response);
                break;
            case "edit":
                updateUser(request, response, userId);
                break;
            case "delete":
                deleteUser(request, response, userId);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    /**
     * List all users
     */
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get search parameter
        String searchTerm = request.getParameter("search");

        List<User> users;
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Search for users
            users = userService.searchUsers(searchTerm);
            request.setAttribute("searchTerm", searchTerm);
        } else {
            // Get all users
            users = userService.getAllUsers();
        }

        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/views/admin/user-list.jsp").forward(request, response);
    }

    /**
     * View a user's details
     */
    private void viewUser(HttpServletRequest request, HttpServletResponse response, String userId)
            throws ServletException, IOException {

        Optional<User> userOpt = userService.getUserById(userId);

        if (!userOpt.isPresent()) {
            // User not found
            request.setAttribute("error", "User not found");
            listUsers(request, response);
            return;
        }

        User user = userOpt.get();
        request.setAttribute("user", user);

        // Forward to the appropriate view based on user type
        String viewPath = user instanceof Customer ?
                "/WEB-INF/views/admin/customer-details.jsp" :
                "/WEB-INF/views/admin/admin-details.jsp";

        request.getRequestDispatcher(viewPath).forward(request, response);
    }

    /**
     * Show form to edit a user
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, String userId)
            throws ServletException, IOException {

        Optional<User> userOpt = userService.getUserById(userId);

        if (!userOpt.isPresent()) {
            // User not found
            request.setAttribute("error", "User not found");
            listUsers(request, response);
            return;
        }

        User user = userOpt.get();
        request.setAttribute("user", user);

        // Forward to the appropriate form based on user type
        String formPath = user instanceof Customer ?
                "/WEB-INF/views/admin/edit-customer.jsp" :
                "/WEB-INF/views/admin/edit-admin.jsp";

        request.getRequestDispatcher(formPath).forward(request, response);
    }

    /**
     * Show form to add a new user
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user type parameter
        String userType = request.getParameter("type");

        // Default to customer if not specified
        if (userType == null || userType.trim().isEmpty()) {
            userType = "customer";
        }

        // Forward to the appropriate form based on user type
        String formPath = userType.equalsIgnoreCase("admin") ?
                "/WEB-INF/views/admin/add-admin.jsp" :
                "/WEB-INF/views/admin/add-customer.jsp";

        request.getRequestDispatcher(formPath).forward(request, response);
    }

    /**
     * Add a new user
     */
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user type parameter
        String userType = request.getParameter("userType");

        // Get common parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            if ("ADMIN".equalsIgnoreCase(userType)) {
                // Admin-specific parameters
                String position = request.getParameter("position");
                String department = request.getParameter("department");

                // Register new admin
                userService.registerAdmin(username, password, fullName, email, phone, position, department);

            } else {
                // Customer-specific parameters
                String driverLicense = request.getParameter("driverLicense");

                // Register new customer
                userService.registerCustomer(username, password, fullName, email, phone, driverLicense);
            }

            // Set success message
            request.setAttribute("message", "User added successfully");

        } catch (IllegalArgumentException e) {
            // Adding failed
            request.setAttribute("error", e.getMessage());
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);

            // Forward back to the add form with the error
            showAddForm(request, response);
            return;
        }

        // Redirect to user list
        response.sendRedirect(request.getContextPath() + "/users/list");
    }

    /**
     * Update an existing user
     */
    private void updateUser(HttpServletRequest request, HttpServletResponse response, String userId)
            throws ServletException, IOException {

        // Get user
        Optional<User> userOpt = userService.getUserById(userId);

        if (!userOpt.isPresent()) {
            // User not found
            request.setAttribute("error", "User not found");
            listUsers(request, response);
            return;
        }

        User user = userOpt.get();

        // Get common parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            // Update common user details
            userService.updateUserDetails(userId, fullName, email, phone);

            // Update specific details based on user type
            if (user instanceof Customer) {
                String driverLicense = request.getParameter("driverLicense");
                userService.updateCustomerDetails(userId, driverLicense);
            } else if (user instanceof Admin) {
                String position = request.getParameter("position");
                String department = request.getParameter("department");
                userService.updateAdminDetails(userId, position, department);
            }

            // Set success message
            request.setAttribute("message", "User updated successfully");

        } catch (IllegalArgumentException e) {
            // Update failed
            request.setAttribute("error", e.getMessage());
            request.setAttribute("user", user);

            // Forward back to the edit form with the error
            showEditForm(request, response, userId);
            return;
        }

        // Show the user details
        viewUser(request, response, userId);
    }

    /**
     * Delete a user
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response, String userId)
            throws IOException {

        // Check if trying to delete self
        HttpSession session = request.getSession(false);
        String currentUserId = (String) session.getAttribute("userId");

        if (userId.equals(currentUserId)) {
            // Can't delete self
            response.sendRedirect(request.getContextPath() + "/users/list?error=You cannot delete your own account");
            return;
        }

        // Delete the user
        boolean deleted = userService.deleteUser(userId);

        if (deleted) {
            // Success
            response.sendRedirect(request.getContextPath() + "/users/list?message=User deleted successfully");
        } else {
            // Failure
            response.sendRedirect(request.getContextPath() + "/users/list?error=Failed to delete user");
        }
    }

    /**
     * Unlock a user account
     */
    private void unlockUser(HttpServletRequest request, HttpServletResponse response, String userId)
            throws IOException {

        // Unlock the account
        boolean unlocked = userService.unlockUserAccount(userId);

        if (unlocked) {
            // Success
            response.sendRedirect(request.getContextPath() + "/users/view/" + userId + "?message=Account unlocked successfully");
        } else {
            // Failure
            response.sendRedirect(request.getContextPath() + "/users/view/" + userId + "?error=Failed to unlock account");
        }
    }

    /**
     * Reset a user's password
     */
    private void resetPassword(HttpServletRequest request, HttpServletResponse response, String userId)
            throws ServletException, IOException {

        // Reset the password
        String newPassword = userService.resetPassword(userId);

        if (newPassword != null) {
            // Success
            request.setAttribute("message", "Password reset successfully. New password: " + newPassword);
            request.setAttribute("newPassword", newPassword);
            viewUser(request, response, userId);
        } else {
            // Failure
            response.sendRedirect(request.getContextPath() + "/users/view/" + userId + "?error=Failed to reset password");
        }
    }
}