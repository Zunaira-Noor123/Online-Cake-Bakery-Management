<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.dao.DeliveryDAO" %>
<%@ page import="com.sweettreats.model.Delivery" %>
<%@ page import="com.sweettreats.model.DeliveryPerson" %>

<%
    // Protect admin access
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Fetch deliveries
    DeliveryDAO dao = new DeliveryDAO();
    List<Delivery> deliveries = dao.getAllDeliveries();
    List<DeliveryPerson> deliveryPersons = dao.getAllDeliveryPersons();

    String queryMessage = request.getParameter("success") != null ? "success" : request.getParameter("error");
    String feedback = "";
    if ("assigned".equals(queryMessage)) {
        feedback = "Delivery Person assigned successfully!";
    } else if ("statusUpdated".equals(queryMessage)) {
        feedback = "Delivery status updated successfully!";
    } else if ("assignFailed".equals(queryMessage) || "statusUpdateFailed".equals(queryMessage)) {
        feedback = "Failed to update delivery information.";
    } else if ("invalidInput".equals(queryMessage)) {
        feedback = "Invalid input received.";
    } else if ("serverError".equals(queryMessage)) {
        feedback = "A server error occurred. Please try again.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Deliveries | Admin</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #ffe6eb;
    padding: 40px 20px;
}

h1 {
    text-align: center;
    color: #e75480;
    font-weight: 700;
    margin-bottom: 30px;
}

.alert {
    max-width: 600px;
    margin: 20px auto;
    border-radius: 20px;
    font-weight: 600;
    text-align: center;
}

.table-container {
    max-width: 1100px;
    margin: auto;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 10px;
}

thead th {
    background: white;
    color: #e75480;
    font-weight: 600;
    padding: 12px 15px;
    border-radius: 15px;
    border: 1px solid #ffc2d1;
    text-align: center;
}

tbody td {
    background: white;
    color: #6c4a5c;
    font-weight: 500;
    padding: 12px 10px;
    border-radius: 12px;
    border: 1px solid #ffc2d1;
    text-align: center;
    vertical-align: middle;
}

tbody tr:hover td {
    background: #ffe6eb;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231,84,128,0.2);
    transition: all 0.2s ease;
}

select.form-control {
    border-radius: 12px;
    border: 1px solid #e75480;
    padding: 4px 6px;
    font-size: 0.9rem;
}

.btn {
    border-radius: 50px;
    padding: 6px 15px;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 0.85rem;
}

.btn-primary {
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: white;
    border: none;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(232,92,143,0.4);
}

.btn-success {
    background: linear-gradient(90deg, #a4def5, #49a9d9);
    color: white;
    border: none;
}

.btn-success:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(73,169,217,0.4);
}

.btn-back {
    display: inline-block;
    margin-top: 20px;
    background: linear-gradient(90deg, #f8a1b3, #e75480);
    color: white;
    padding: 10px 30px;
    border-radius: 50px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.btn-back:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(231,84,128,0.4);
}

@media (max-width: 768px) {
    table, thead, tbody, th, td, tr {
        display: block;
    }
    
    thead tr {
        display: none;
    }
    
    tbody td {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 15px;
    }
    
    tbody td::before {
        content: attr(data-label);
        font-weight: 600;
        color: #e75480;
    }
}
</style>
</head>

<body>

<h1>Manage Deliveries</h1>

<% if (!feedback.isEmpty()) { %>
    <div class="alert <%= "success".equals(queryMessage) ? "alert-success" : "alert-danger" %> text-center">
        <%= feedback %>
    </div>
<% } %>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Order ID</th>
                <th>Delivery Person</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Updated At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (Delivery delivery : deliveries) { %>
            <tr>
                <td data-label="ID"><%= delivery.getId() %></td>
                <td data-label="Order ID"><%= delivery.getOrderId() %></td>
                <td data-label="Delivery Person">
                    <%= delivery.getDeliveryPersonId() != null ? 
                        deliveryPersons.stream()
                            .filter(person -> person.getId() == delivery.getDeliveryPersonId())
                            .map(DeliveryPerson::getUsername)
                            .findFirst()
                            .orElse("Unassigned") 
                        : "Unassigned" %>
                </td>
                <td data-label="Status"><%= delivery.getStatus() %></td>
                <td data-label="Created At"><%= delivery.getCreatedAt() %></td>
                <td data-label="Updated At"><%= delivery.getUpdatedAt() %></td>
                <td data-label="Actions">
                    <!-- Assign Delivery Person -->
                    <form action="DeliveryManagementServlet" method="POST" style="display:inline-block;">
                        <input type="hidden" name="deliveryId" value="<%= delivery.getId() %>">
                        <select name="deliveryPersonId" class="form-control mb-1">
                            <option value="">Unassigned</option>
                            <% for (DeliveryPerson person : deliveryPersons) { %>
                                <option value="<%= person.getId() %>" <%= delivery.getDeliveryPersonId() != null && delivery.getDeliveryPersonId() == person.getId() ? "selected" : "" %>>
                                    <%= person.getUsername() %>
                                </option>
                            <% } %>
                        </select>
                        <button type="submit" name="action" value="assign" class="btn btn-primary btn-sm">Assign</button>
                    </form>

                    <!-- Update Status -->
                    <form action="DeliveryManagementServlet" method="POST" style="display:inline-block;">
                        <input type="hidden" name="deliveryId" value="<%= delivery.getId() %>">
                        <select name="status" class="form-control mb-1">
                            <option value="pending" <%= "pending".equals(delivery.getStatus()) ? "selected" : "" %>>Pending</option>
                            <option value="in_progress" <%= "in_progress".equals(delivery.getStatus()) ? "selected" : "" %>>In Progress</option>
                            <option value="delivered" <%= "delivered".equals(delivery.getStatus()) ? "selected" : "" %>>Delivered</option>
                        </select>
                        <button type="submit" name="action" value="updateStatus" class="btn btn-success btn-sm">Update</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<div class="text-center">
    <a href="adminDashboard.jsp" class="btn-back">Back to Dashboard</a>
</div>

</body>
</html>

