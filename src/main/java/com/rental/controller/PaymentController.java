package com.rental.vehiclerentalsystem2_0.controller;

import com.rental.vehiclerentalsystem2_0.dto.PaymentDTO;
import com.rental.vehiclerentalsystem2_0.dto.PaymentResponseDTO;
import com.rental.vehiclerentalsystem2_0.service.PaymentService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RestController
@RequestMapping("/api/payments")
public class PaymentController {

    private final PaymentService paymentService;

    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/process")
    public ResponseEntity<PaymentResponseDTO> processPayment(@Valid @RequestBody PaymentDTO paymentDTO) {
        PaymentResponseDTO response = paymentService.processPayment(paymentDTO);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<PaymentResponseDTO> getPaymentStatus(@PathVariable Long id) {
        PaymentResponseDTO response = paymentService.getPaymentById(id);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/verify/{id}")
    public ResponseEntity<PaymentResponseDTO> verifyPayment(@PathVariable Long id) {
        PaymentResponseDTO response = paymentService.verifyPayment(id);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/methods")
    public ResponseEntity<Object> getAvailablePaymentMethods() {
        return ResponseEntity.ok(paymentService.getAvailablePaymentMethods());
    }

    /**
     * Process a simple payment from the web flow
     * This endpoint is called from the web form submission
     */
    @PostMapping("/web/process/{rentalId}")
    public ResponseEntity<PaymentResponseDTO> processWebPayment(
            @PathVariable Long rentalId,
            @RequestParam String paymentMethod) {
        PaymentResponseDTO response = paymentService.processSimplePayment(rentalId, paymentMethod);
        return ResponseEntity.ok(response);
    }
}