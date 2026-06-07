package com.rental.vehiclerentalsystem2_0.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/utilities")
    public String showUtilitiesPage() {
        return "admin-utilities";
    }
}