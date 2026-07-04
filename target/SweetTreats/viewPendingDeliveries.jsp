<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.model.Delivery" %>

<%
    List<Delivery> pendingDeliveries = (List<Delivery>) request.getAttribute("pendingDeliveries");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Pending Deliveries | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6ea, #ffd6e0, #ffc2d1);
    min-height: 100vh;
    padding: 40px 20px;
}

/* Page Header */
h1 {
    text-align: center;
    color: #e75480;
    font-weight: 700;
    margin-bottom: 40px;
}

/* Container */
.table-container {
    max-width: 900px;
    margin: auto;
}

/* Delivery Card */
.delivery-card {
    background: #fff0f3;
    border-radius: 20px;
    margin-bottom: 20px;
    padding: 20px 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 8px 20px rgba(231, 84, 128, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.delivery-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(231, 84, 128, 0.3);
}

.delivery-info {
    display: flex;
    flex-direction: column;
}

.delivery-info span {
    color: #6c4a5c;
    font-weight: 500;
    margin: 3px 0;
}

.delivery-status {
    padding: 6px 15px;
    border-radius: 50px;
    font-weight: 600;
    font-size: 0.9rem;
    color: white;
    text-transform: capitalize;
}

/* Status Colors */
.status-pending { background: #ffb3b3; }
.status-in_progress { background: #f5b0c1; }
.status-delivered { background: #a4def5; color: #1e3d59; }

/* Buttons */
.btn-back {
    display: inline-block;
    margin: 30px auto 0;
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: white;
    padding: 12px 30px;
    border-radius: 50px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.btn-back:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(232,92,143,0.35);
}

@media (max-width: 768px) {
    .delivery-card {
        flex-direction: column;
        align-items: flex-start;
    }
}
</style>
</head>
<body>

<div class="table-container">
    <h1>Pending Deliveries</h1>

    <% if (pendingDeliveries != null && !pendingDeliveries.isEmpty()) { %>
        <% for (Delivery delivery : pendingDeliveries) { %>
            <div class="delivery-card">
                <div class="delivery-info">
                    <span><i class="fa-solid fa-box"></i> Delivery ID: <%= delivery.getId() %></span>
                    <span><i class="fa-solid fa-receipt"></i> Order ID: <%= delivery.getOrderId() %></span>
                    <span><i class="fa-solid fa-calendar-days"></i> Created: <%= delivery.getCreatedAt() %></span>
                    <span><i class="fa-solid fa-clock"></i> Updated: <%= delivery.getUpdatedAt() %></span>
                </div>
                <div class="delivery-status status-<%= delivery.getStatus() %>">
                    <i class="fa-solid fa-truck"></i> <%= delivery.getStatus() %>
                </div>
            </div>
        <% } %>
    <% } else { %>
        <div class="delivery-card justify-content-center">
            <span class="text-center w-100">No pending deliveries available.</span>
        </div>
    <% } %>

    <div class="text-center">
        <a href="deliveryDashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>
</div>

</body>
</html>
