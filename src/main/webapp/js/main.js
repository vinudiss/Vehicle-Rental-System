/**
 * Main JavaScript file for the Vehicle Rental System
 */

document.addEventListener('DOMContentLoaded', function() {
    // Mobile navigation toggle
    const navbarToggle = document.getElementById('navbar-toggle');
    if (navbarToggle) {
        navbarToggle.addEventListener('click', function() {
            document.getElementById('navbar-nav').classList.toggle('show');
        });
    }

    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    if (alerts.length > 0) {
        setTimeout(function() {
            alerts.forEach(function(alert) {
                if (alert) {
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        if (alert.parentNode) {
                            alert.parentNode.removeChild(alert);
                        }
                    }, 500);
                }
            });
        }, 5000);
    }

    // Form validation helpers
    const forms = document.querySelectorAll('form');
    forms.forEach(function(form) {
        // Add validation classes to required fields
        const requiredInputs = form.querySelectorAll('[required]');
        requiredInputs.forEach(function(input) {
            input.addEventListener('blur', function() {
                if (!input.value.trim()) {
                    input.classList.add('invalid');
                } else {
                    input.classList.remove('invalid');
                }
            });
        });
    });

    // Table row highlighting
    const tableRows = document.querySelectorAll('table tr');
    tableRows.forEach(function(row) {
        row.addEventListener('mouseover', function() {
            this.classList.add('highlight');
        });
        row.addEventListener('mouseout', function() {
            this.classList.remove('highlight');
        });
    });

    // Confirmation dialogs for delete/cancel actions
    const dangerousActions = document.querySelectorAll('.btn-danger');
    dangerousActions.forEach(function(button) {
        button.addEventListener('click', function(event) {
            const confirmText = button.getAttribute('data-confirm') || 'Are you sure you want to perform this action?';
            if (!confirm(confirmText)) {
                event.preventDefault();
            }
        });
    });

    // Date input enhancement
    const dateInputs = document.querySelectorAll('input[type="date"]');
    dateInputs.forEach(function(input) {
        // Set minimum date to today by default if not already set
        if (!input.min) {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            input.min = yyyy + '-' + mm + '-' + dd;
        }
    });
});