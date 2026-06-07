<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="sidebar">
    <div class="sidebar-header">
        <c:choose>
            <c:when test="${sessionScope.userType == 'ADMIN'}">
                <h3>Admin Panel</h3>
            </c:when>
            <c:otherwise>
                <h3>User Menu</h3>
            </c:otherwise>
        </c:choose>
    </div>

    <ul class="sidebar-menu">
        <c:if test="${sessionScope.userType == 'ADMIN'}">
            <!-- Admin navigation -->
            <li class="${currentPage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            </li>
            <li class="${currentPage == 'users' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/users/list">Manage Users</a>
            </li>
            <li class="${currentPage == 'vehicles' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/vehicles/list">Manage Vehicles</a>
            </li>
            <li class="${currentPage == 'rentals' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/rentals/list">Manage Rentals</a>
            </li>
            <li class="${currentPage == 'reports' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/rentals/report">Reports</a>
            </li>
        </c:if>

        <c:if test="${sessionScope.userType == 'CUSTOMER'}">
            <!-- Customer navigation -->
            <li class="${currentPage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/customer/dashboard">Dashboard</a>
            </li>
            <li class="${currentPage == 'catalog' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/vehicles/catalog">Browse Vehicles</a>
            </li>
            <li class="${currentPage == 'rentals' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/rentals/list">My Rentals</a>
            </li>
            <li class="${currentPage == 'history' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/rentals/history">Rental History</a>
            </li>
            <li class="${currentPage == 'profile' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/customer/profile">My Profile</a>
            </li>
        </c:if>

        <li>
            <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
        </li>
    </ul>
</nav>