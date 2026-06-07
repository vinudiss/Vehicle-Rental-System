<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>User Management - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="container">
    <h1>User Management</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="admin-actions">
        <a href="${pageContext.request.contextPath}/users/add?type=customer" class="btn btn-primary">Add Customer</a>
        <a href="${pageContext.request.contextPath}/users/add?type=admin" class="btn btn-primary">Add Admin</a>
    </div>

    <div class="search-section">
        <form action="${pageContext.request.contextPath}/users/list" method="get" class="search-form">
            <div class="search-group">
                <input type="text" name="search" placeholder="Search by name, username, or email..." value="${searchTerm}">
                <button type="submit" class="btn btn-primary">Search</button>
                <c:if test="${not empty searchTerm}">
                    <a href="${pageContext.request.contextPath}/users/list" class="btn btn-secondary">Clear</a>
                </c:if>
            </div>
        </form>
    </div>

    <div class="user-list">
        <c:if test="${empty users}">
            <p class="no-results">No users found.</p>
        </c:if>

        <c:if test="${not empty users}">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Registration Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.userId}</td>
                        <td>${user.username}</td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.userType}</td>
                        <td class="user-status ${user.locked ? 'locked' : 'active'}">
                                ${user.locked ? 'Locked' : 'Active'}
                        </td>
                        <td><fmt:formatDate value="${user.registrationDate}" pattern="MMM dd, yyyy" /></td>
                        <td class="actions-cell">
                            <a href="${pageContext.request.contextPath}/users/view/${user.userId}" class="btn btn-sm">View</a>
                            <a href="${pageContext.request.contextPath}/users/edit/${user.userId}" class="btn btn-sm">Edit</a>
                            <c:if test="${user.locked}">
                                <a href="${pageContext.request.contextPath}/users/unlock/${user.userId}" class="btn btn-sm btn-warning">Unlock</a>
                            </c:if>
                            <c:if test="${user.userId != sessionScope.userId}">
                                <form action="${pageContext.request.contextPath}/users/delete/${user.userId}" method="post" class="inline-form" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>