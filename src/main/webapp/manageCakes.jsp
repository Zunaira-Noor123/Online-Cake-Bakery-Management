<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.model.Cake" %>
<%@ page import="com.sweettreats.dao.CakeDAO" %>

<%
    // Protect admin access
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Cakes | Admin</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #ffe6eb, #ffd6e0, #ffc2d1);
        min-height: 100vh;
        padding: 40px 20px;
    }

    h1 {
        text-align: center;
        color: #e75480;
        font-weight: 700;
        margin-bottom: 40px;
    }

    /* Form Card */
    .add-cake-form {
        background: rgba(255,255,255,0.95);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 15px 35px rgba(231,84,128,0.2);
        margin-bottom: 50px;
        max-width: 700px;
        margin-left: auto;
        margin-right: auto;
    }

    .form-label {
        font-weight: 600;
        color: #6c4a5c;
    }

    .btn-success, .btn-primary, .btn-danger {
        border-radius: 50px;
        font-weight: 600;
        padding: 10px 25px;
        transition: all 0.3s ease;
    }

    .btn-success {
        background: linear-gradient(90deg, #f8a1b3, #e75480);
        border: none;
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(231,84,128,0.4);
    }

    .btn-primary {
        background: linear-gradient(90deg, #f5b0c1, #e85c8f);
        border: none;
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(232,92,143,0.4);
    }

    .btn-danger {
        background: linear-gradient(90deg, #f08091, #dc3545);
        border: none;
    }

    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(220,53,69,0.4);
    }

    /* Cake Cards */
    .cake-card {
        background: rgba(255,255,255,0.95);
        border-radius: 20px;
        box-shadow: 0 10px 25px rgba(231,84,128,0.15);
        overflow: hidden;
        transition: transform 0.3s ease;
        margin-bottom: 30px;
    }

    .cake-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(231,84,128,0.25);
    }

    .cake-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }

    .cake-body {
        padding: 15px 20px;
    }

    .cake-title {
        font-weight: 700;
        color: #e75480;
        margin-bottom: 10px;
    }

    .cake-price {
        font-weight: 600;
        color: #6c4a5c;
        margin-bottom: 10px;
    }

    .cake-desc, .cake-ingredients {
        font-size: 0.95rem;
        color: #7b6f73;
        margin-bottom: 10px;
    }

    .actions {
        text-align: right;
    }

    .cake-grid {
        display: grid;
        grid-template-columns: 1fr;
        gap: 20px;
    }

    @media (min-width: 768px) {
        .cake-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (min-width: 1200px) {
        .cake-grid {
            grid-template-columns: repeat(3, 1fr);
        }
    }

    /* Back Button at Bottom */
    .back-btn {
        display: inline-block;
        margin: 40px auto 20px auto;
        background: linear-gradient(90deg, #f8a1b3, #e75480);
        color: white;
        padding: 12px 35px;
        border-radius: 50px;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .back-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba(231,84,128,0.4);
    }
</style>
</head>
<body>

<h1>Manage Cakes</h1>

<!-- Add Cake Form -->
<div class="add-cake-form">
    <h3 class="text-center mb-4">Add New Cake</h3>
    <form action="CakeManagementServlet" method="POST">
        <div class="row mb-3">
            <div class="col-md-6 mb-3 mb-md-0">
                <label for="cakeName" class="form-label">Cake Name</label>
                <input type="text" class="form-control" id="cakeName" name="cakeName" required>
            </div>
            <div class="col-md-6">
                <label for="cakePrice" class="form-label">Price (Rs)</label>
                <input type="number" class="form-control" id="cakePrice" name="cakePrice" step="0.01" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="cakeDescription" class="form-label">Description</label>
            <textarea class="form-control" id="cakeDescription" name="cakeDescription" rows="3" required></textarea>
        </div>

        <div class="mb-3">
            <label for="cakeIngredients" class="form-label">Ingredients</label>
            <textarea class="form-control" id="cakeIngredients" name="cakeIngredients" rows="2"></textarea>
        </div>

        <div class="mb-3">
            <label for="cakeImage" class="form-label">Image Path</label>
            <input type="text" class="form-control" id="cakeImage" name="cakeImage" placeholder="e.g., images/chocolate.jpg" required>
        </div>

        <button type="submit" name="action" value="add" class="btn btn-success w-100">Add Cake</button>
    </form>
</div>

<!-- List of Cakes -->
<div class="container">
    <h3 class="text-center mb-4">All Cakes</h3>
    <div class="cake-grid">
        <%
            CakeDAO dao = new CakeDAO();
            List<Cake> cakes = dao.getAllCakes();
            for (Cake cake : cakes) {
        %>
        <div class="cake-card">
            <img src="<%= cake.getImageUrl() %>" alt="<%= cake.getName() %>">
            <div class="cake-body">
                <div class="cake-title"><%= cake.getName() %></div>
                <div class="cake-price">Rs <%= String.format("%.2f", cake.getPrice()) %></div>
                <div class="cake-desc"><%= cake.getDescription() %></div>
                <div class="cake-ingredients"><strong>Ingredients:</strong> <%= cake.getIngredients() %></div>
                <div class="actions">
                    <form action="CakeManagementServlet" method="POST" style="display:inline-block;">
                        <input type="hidden" name="cakeId" value="<%= cake.getId() %>">
                        <input type="hidden" name="action" value="delete">
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                    <a href="editCake.jsp?cakeId=<%= cake.getId() %>" class="btn btn-primary btn-sm">Edit</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Back to Dashboard Button at Bottom -->
    <div class="text-center">
        <a href="adminDashboard.jsp" class="back-btn">Back to Dashboard</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
