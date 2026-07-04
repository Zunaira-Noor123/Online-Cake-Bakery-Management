<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Cake | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center">Add Cake</h1>
        <form action="CakeManagementServlet" method="POST" class="mt-4">
            <div class="mb-3">
                <label for="cakeName" class="form-label">Cake Name</label>
                <input type="text" id="cakeName" name="cakeName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="cakePrice" class="form-label">Price (Rs)</label>
                <input type="number" id="cakePrice" name="cakePrice" class="form-control" step="0.01" required>
            </div>
            <div class="mb-3">
                <label for="cakeDescription" class="form-label">Description</label>
                <textarea id="cakeDescription" name="cakeDescription" class="form-control" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label for="cakeIngredients" class="form-label">Ingredients</label>
                <textarea id="cakeIngredients" name="cakeIngredients" class="form-control" rows="2"></textarea>
            </div>
            <div class="mb-3">
                <label for="cakeImage" class="form-label">Image Path</label>
                <input type="text" id="cakeImage" name="cakeImage" class="form-control" required>
            </div>
            <button type="submit" name="action" value="add" class="btn btn-success">Add Cake</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>