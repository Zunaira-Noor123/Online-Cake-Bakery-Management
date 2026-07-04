<%-- 
    Document   : index.jsp
    Created on : Dec 27, 2025, 1:48:32 PM
    Author     : G7
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SweetTreats Bakery</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp">SweetTreats Bakery</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item"><a class="nav-link" href="cakes.jsp">Cakes</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <h1>Welcome to SweetTreats Bakery!</h1>
        <p>Delicious cakes delivered to your doorstep.</p>

        <!-- Example Banner -->
        <div class="card bg-light text-dark mt-3">
            <img src="https://images.unsplash.com/photo-1606755962773-9b016c3e2e7e" class="card-img" alt="Cakes">
            <div class="card-img-overlay d-flex align-items-center justify-content-center">
                <h2 class="card-title text-center bg-white p-2 rounded">Fresh Cakes Every Day!</h2>
            </div>
        </div>
    </div>
</body>
</html>
