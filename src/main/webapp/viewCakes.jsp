<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.model.Cake" %>
<%@ page import="com.sweettreats.dao.CakeDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cakes | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Manage Cakes</h1>
        <a href="addCake.jsp" class="btn btn-success mb-3">Add Cake</a> <!-- Navigate to Add Cake -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Ingredients</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    CakeDAO dao = new CakeDAO();
                    List<Cake> cakes = dao.getAllCakes();
                    for (Cake cake : cakes) { 
                %>
                <tr>
                    <td><%= cake.getId() %></td>
                    <td><%= cake.getName() %></td>
                    <td>$<%= String.format("%.2f", cake.getPrice()) %></td>
                    <td><%= cake.getDescription() %></td>
                    <td><%= cake.getIngredients() %></td>
                    <td><img src="<%= cake.getImageUrl() %>" alt="<%= cake.getName() %>" width="100"></td>
                    <td>
                        <!-- Delete Cake -->
                        <form action="CakeManagementServlet" method="POST" style="display:inline-block;">
                            <input type="hidden" name="cakeId" value="<%= cake.getId() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                        <!-- Redirect to Edit Cake -->
                        <a href="editCake.jsp?cakeId=<%= cake.getId() %>" class="btn btn-primary">Edit</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>