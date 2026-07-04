<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String cakeId = request.getParameter("cakeId");
    String cakeName = (String) request.getAttribute("cakeName");
    String cakeDescription = (String) request.getAttribute("cakeDescription");
    double cakePrice = (double) request.getAttribute("cakePrice");
    String cakeIngredients = (String) request.getAttribute("cakeIngredients");
    String cakeImage = (String) request.getAttribute("cakeImage");

    if (cakeName == null) cakeName = "Unknown Cake";
    if (cakeDescription == null) cakeDescription = "No description available.";
    if (cakeIngredients == null) cakeIngredients = "Ingredients not available.";
    if (cakeImage == null) cakeImage = "default-cake.jpg";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= cakeName %> | Sweet Treats Bakery</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<!-- Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background:
            radial-gradient(circle at 10% 10%, #ffe0eb, transparent 35%),
            radial-gradient(circle at 90% 90%, #fff0f6, transparent 40%),
            linear-gradient(135deg, #fff6fa, #ffffff);
    }

    .container {
        margin-top: 40px;
    }

    .cake-container {
        display: flex;
        gap: 30px;
        align-items: center;
        justify-content: center;
        flex-wrap: wrap;
    }

    .cake-image {
        width: 380px;
        height: 380px;
        object-fit: cover;
        border-radius: 30px;
        box-shadow: 0 25px 60px rgba(255,160,190,.35);
    }

    .cake-info {
        max-width: 520px;
        background: white;
        padding: 25px;
        border-radius: 30px;
        box-shadow: 0 25px 60px rgba(255,160,190,.35);
    }

    .cake-title {
        font-family: 'Pacifico', cursive;
        color: #ff6f91;
        font-size: 2.8rem;
        margin-bottom: 10px;
        text-align: center;
    }

    .price-tag {
        text-align: center;
        font-size: 2rem;
        color: #ff6f91;
        font-weight: 700;
        margin-bottom: 20px;
    }

    .cake-desc, .cake-ingredients {
        color: #555;
        line-height: 1.6;
        margin-bottom: 12px;
    }

    .btn-add-to-cart {
        background: linear-gradient(90deg,#ff8fab,#ffb3c6);
        color: white;
        border: none;
        border-radius: 30px;
        padding: 10px 25px;
        font-weight: 600;
        cursor: pointer;
    }

    .btn-back {
        background: white;
        border: 2px solid #ff8fab;
        color: #ff6f91;
        border-radius: 30px;
        padding: 10px 25px;
        font-weight: 600;
    }

</style>
</head>

<body>

<div class="container">
    <div class="cake-container">
        <!-- Cake Image -->
        <img src="<%= cakeImage %>" alt="<%= cakeName %>" class="cake-image">

        <!-- Info Section -->
        <div class="cake-info">
            <h1 class="cake-title"><%= cakeName %></h1>
            <div class="price-tag">Rs <%= String.format("%.2f", cakePrice) %></div>

            <div class="cake-desc"><strong>Description:</strong> <%= cakeDescription %></div>
            <div class="cake-ingredients"><strong>Ingredients:</strong> <%= cakeIngredients %></div>

            <div class="d-flex flex-wrap justify-content-center mt-3">
                <form action="AddToCartServlet" method="POST">
                    <input type="hidden" name="cakeId" value="<%= cakeId %>">
                    <input type="hidden" name="cakeName" value="<%= cakeName %>">
                    <input type="hidden" name="cakePrice" value="<%= cakePrice %>">
                    <button type="submit" class="btn-add-to-cart mb-2">
                        <i class="fa-solid fa-cart-plus"></i> Add to Cart
                    </button>
                </form>

                <a href="cakes.jsp" class="btn btn-back mb-2">
                    <i class="fa-solid fa-arrow-left"></i> Back to Cakes
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
