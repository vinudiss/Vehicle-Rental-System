<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header">
    <div class="container">
        <div class="navbar">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">Vehicle Rental System</a>
            <button class="navbar-toggle" id="navbar-toggle">
                <i class="fas fa-bars"></i>
            </button>
            <ul class="navbar-nav" id="navbar-nav">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <!-- Not logged in -->
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/" class="nav-link">Home</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/auth/login" class="nav-link">Login</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/auth/register" class="nav-link">Register</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- User is logged in -->
                        <c:if test="${sessionScope.userType == 'ADMIN'}">
                            <!-- Admin navigation -->
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/users/list" class="nav-link">Users</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/vehicles/list" class="nav-link">Vehicles</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/list" class="nav-link">Rentals</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/report" class="nav-link">Reports</a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.userType == 'CUSTOMER'}">
                            <!-- Customer navigation -->
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/customer/dashboard" class="nav-link">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/vehicles/catalog" class="nav-link">Vehicles</a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/rentals/list" class="nav-link">My Rentals</a>
                            </li>
                        </c:if>

                        <!-- User menu for all logged-in users -->
                        <li class="nav-item user-menu">
                            <a href="#" class="nav-link">${sessionScope.username} <i class="fas fa-chevron-down"></i></a>
                            <div class="dropdown-menu">
                                <c:if test="${sessionScope.userType == 'CUSTOMER'}">
                                    <a href="${pageContext.request.contextPath}/customer/profile" class="dropdown-item">My Profile</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item">Logout</a>
                            </div>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</header>

<script>
    // Mobile navigation toggle
    document.addEventListener('DOMContentLoaded', function() {
        const navbarToggle = document.getElementById('navbar-toggle');
        if (navbarToggle) {
            navbarToggle.addEventListener('click', function() {
                document.getElementById('navbar-nav').classList.toggle('show');
            });
        }
    });
</script>