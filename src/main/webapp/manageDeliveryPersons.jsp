<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.dao.DeliveryPersonDAO" %>
<%@ page import="com.sweettreats.model.DeliveryPerson" %>

<%
    // Protect admin access
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Fetch delivery personnel from database
    DeliveryPersonDAO dao = new DeliveryPersonDAO();
    List<DeliveryPerson> deliveryPersons = dao.getAllDeliveryPersons();

    String queryMessage = request.getParameter("success") != null ? "success" : request.getParameter("error");
    String feedback = "";
    if ("added".equals(queryMessage)) {
        feedback = "Delivery Person added successfully!";
    } else if ("updated".equals(queryMessage)) {
        feedback = "Delivery Person updated successfully!";
    } else if ("deleted".equals(queryMessage)) {
        feedback = "Delivery Person deleted successfully!";
    } else if ("actionFailed".equals(queryMessage)) {
        feedback = "Action failed. Please try again.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Delivery Personnel | Admin</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6eb, #ffd6e0);
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

.form-container {
    max-width: 600px;
    margin: 40px auto;
    background: #fff;
    padding: 30px 20px;
    border-radius: 15px;
    box-shadow: 0 10px 20px rgba(231, 84, 128, 0.2);
}

.table-container {
    max-width: 1100px;
    margin: 40px auto;
}

table {
    width: 100%;
    border-collapse: collapse;
}

thead th {
    background: white;
    color: #e75480;
    font-weight: 600;
    padding: 12px 15px;
    text-align: center;
    border: 1px solid #ffc2d1;
}

tbody td {
    background: white;
    color: #6c4a5c;
    font-weight: 500;
    padding: 12px 10px;
    border: 1px solid #ffc2d1;
    text-align: center;
}

tbody tr:hover td {
    background: #ffe6eb;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231, 84, 128, 0.2);
    transition: all 0.2s ease;
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
    box-shadow: 0 8px 20px rgba(232, 92, 143, 0.4);
}

.btn-danger {
    background: linear-gradient(90deg, #ea5353, #d32f2f);
    color: white;
    border: none;
}

.btn-danger:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(220, 53, 69, 0.4);
}

.btn-success {
    background: linear-gradient(90deg, #a4def5, #49a9d9);
    color: white;
    border: none;
}

.btn-success:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(73, 169, 217, 0.4);
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
    box-shadow: 0 10px 30px rgba(231, 84, 128, 0.4);
}
</style>
</head>
<body>

<h1>Manage Delivery Personnel</h1>

<% if (!feedback.isEmpty()) { %>
    <div class="alert <%= "success".equals(queryMessage) ? "alert-success" : "alert-danger" %> text-center">
        <%= feedback %>
    </div>
<% } %>

<div class="form-container">
    <h3 class="text-center mb-4">Add New Delivery Personnel</h3>
    <form action="DeliveryPersonManagementServlet" method="POST">
        <div class="mb-3">
            <label for="deliveryPersonName" class="form-label">Name</label>
            <input type="text" class="form-control" id="deliveryPersonName" name="name" required>
        </div>
        <div class="mb-3">
            <label for="deliveryPersonEmail" class="form-label">Email</label>
            <input type="email" class="form-control" id="deliveryPersonEmail" name="email" required>
        </div>
        <button type="submit" name="action" value="add" class="btn btn-success w-100">Add Delivery Personnel</button>
    </form>
</div>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (DeliveryPerson person : deliveryPersons) { %>
            <tr>
                <td><%= person.getId() %></td>
                <td><%= person.getName() %></td>
                <td><%= person.getEmail() %></td>
                <td><%= person.getCreatedAt() %></td>
                <td>
                    <!-- Edit -->
                    <form action="DeliveryPersonManagementServlet" method="POST" style="display:inline-block;">
                        <input type="hidden" name="id" value="<%= person.getId() %>">
                        <button type="submit" name="action" value="edit" class="btn btn-primary btn-sm">Edit</button>
                    </form>
                    
                    <!-- Delete -->
                    <form action="DeliveryPersonManagementServlet" method="POST" style="display:inline-block;">
                        <input type="hidden" name="id" value="<%= person.getId() %>">
                        <button type="submit" name="action" value="delete" class="btn btn-danger btn-sm">Delete</button>
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