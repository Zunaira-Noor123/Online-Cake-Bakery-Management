<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sweettreats.dao.CakeDAO" %>
<%@ page import="com.sweettreats.model.Cake" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int cakeId = Integer.parseInt(request.getParameter("cakeId"));
    CakeDAO dao = new CakeDAO();
    Cake cake = dao.getCakeById(cakeId);

    if (cake == null) {
        response.sendRedirect("manageCakes.jsp?error=cakeNotFound");
        return;
    }

    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Cake | Admin</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Soft Pink Style Enhancements -->
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: linear-gradient(120deg, #ffe6f0, #fff0f5);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 60px auto;
            padding: 25px 30px;
            background: #fff0f5;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(255, 182, 193, 0.3);
            transition: transform 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
        }

        h1 {
            margin-bottom: 30px;
            color: #ff69b4; /* bright pink */
            text-align: center;
            font-weight: 600;
        }

        label {
            font-weight: 500;
            color: #ff4c8b;
        }

        .form-control {
            border-radius: 10px;
            border: 1px solid #ffb6c1;
            padding: 10px;
        }

        .form-control:focus {
            border-color: #ff69b4;
            box-shadow: 0 0 8px rgba(255, 105, 180, 0.2);
        }

        .btn-primary {
            background-color: #ff69b4;
            border-color: #ff69b4;
            font-weight: 500;
        }
        .btn-primary:hover {
            background-color: #ff85c1;
            border-color: #ff85c1;
        }

        .alert-success {
            background-color: #ffe6f0;
            color: #ff4c8b;
            border: 1px solid #ffb6c1;
        }

        .alert-danger {
            background-color: #ffdce6;
            color: #ff1a66;
            border: 1px solid #ff85c1;
        }

        small.form-text {
            color: #ff4c8b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Cake</h1>

        <!-- Feedback Messages -->
        <%
            if (successMessage != null) {
        %>
            <div class="alert alert-success text-center">
                <%= successMessage %>
            </div>
        <%
            } else if (errorMessage != null) {
        %>
            <div class="alert alert-danger text-center">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form action="CakeManagementServlet" method="POST" class="needs-validation" novalidate>
            <input type="hidden" name="cakeId" value="<%= cake.getId() %>" />

            <div class="mb-3">
                <label for="cakeName" class="form-label">Cake Name</label>
                <input type="text" id="cakeName" name="cakeName" class="form-control" value="<%= cake.getName() %>" required>
                <div class="invalid-feedback">Please enter a valid cake name.</div>
            </div>

            <div class="mb-3">
                <label for="cakePrice" class="form-label">Price (Rs)</label>
                <input type="number" id="cakePrice" name="cakePrice" class="form-control" step="0.01" value="<%= cake.getPrice() %>" required>
                <div class="invalid-feedback">Please enter a valid price.</div>
            </div>

            <div class="mb-3">
                <label for="cakeDescription" class="form-label">Description</label>
                <textarea id="cakeDescription" name="cakeDescription" class="form-control" rows="3" required><%= cake.getDescription() %></textarea>
                <div class="invalid-feedback">Please provide a description for the cake.</div>
            </div>

            <div class="mb-3">
                <label for="cakeIngredients" class="form-label">Ingredients</label>
                <textarea id="cakeIngredients" name="cakeIngredients" class="form-control" rows="2"><%= cake.getIngredients() %></textarea>
                <small class="form-text text-muted">Comma-separated (e.g., flour, sugar, cocoa).</small>
            </div>

            <div class="mb-3">
                <label for="cakeImage" class="form-label">Image Path</label>
                <input type="text" id="cakeImage" name="cakeImage" class="form-control" value="<%= cake.getImageUrl() %>" required>
                <small class="form-text text-muted">Provide the relative path to the image (e.g., "images/cake.jpg").</small>
                <div class="invalid-feedback">Please provide a valid image path.</div>
            </div>

            <button type="submit" name="action" value="edit" class="btn btn-primary w-100">Update Cake</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (function () {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>
