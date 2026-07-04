<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.sweettreats.model.Cake" %>

<%
    // Retrieve the cart from the session
    Map<Cake, Integer> cart = (Map<Cake, Integer>) session.getAttribute("cart");
    double totalPrice = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#fefefe">
    <title>Your Cart | Sweet Treats Bakery</title>
    
    <!-- External Libraries -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;700&family=Pacifico&display=swap" rel="stylesheet">
    
    <!-- Styles -->
    <style>
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #fefbe9; /* Soft cream background */
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #ff7f8a; /* Gentle pink */
            text-align: center;
            margin-top: 30px;
            font-family: 'Pacifico', cursive;
            font-size: 2.5rem;
        }

        .table {
            margin-top: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background-color: #ffccb5; /* Light pink */
            color: #444;
            font-weight: bold;
            font-size: 1rem;
        }

        .table td {
            color: #444;
            font-size: 0.95rem;
        }

        .btn-soft {
            background-color: #ff7f8a; /* Gentle pink */
            color: white;
            border-radius: 30px;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(255, 127, 138, 0.3);
        }

        .btn-soft:hover {
            background-color: #ff9fad; /* Softer pink hover effect */
            box-shadow: 0 4px 15px rgba(255, 127, 138, 0.5);
        }

        .btn-danger {
            border-radius: 20px;
            font-size: 0.9rem;
        }

        .empty-cart {
            text-align: center;
            font-size: 1.2rem;
            margin-top: 40px;
        }

        footer {
            background-color: #ffeaeb; /* Gentle pink footer */
            color: #444;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
        }
    </style>
</head>
<body>

    <!-- Cart Container -->
    <div class="container mt-5">
        <h2>Your Cart</h2>

        <%
            if (cart == null || cart.isEmpty()) {
        %>
            <!-- Empty Cart Message -->
            <p class="empty-cart">
                Your cart is empty ❤️. <a href="cakes.jsp" style="color:#ff7f8a; text-decoration:underline;">Continue shopping.</a>
            </p>
        <%
            } else {
        %>
            <!-- Cart Table -->
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th>Cake Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map.Entry<Cake, Integer> entry : cart.entrySet()) {
                           Cake cake = entry.getKey();
                           Integer quantity = entry.getValue();
                           double subtotal = cake.getPrice() * quantity;
                           totalPrice += subtotal;
                    %>
                    <tr>
                        <td><%= cake.getName() %></td>
                        <td>Rs <%= cake.getPrice() %></td>
                        <td><%= quantity %></td>
                        <td>Rs <%= subtotal %></td>
                        <td>
                            <!-- Remove Button -->
                            <form action="RemoveFromCartServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="cakeId" value="<%= cake.getId() %>">
                                <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <!-- Cart Summary -->
            <div class="text-end mt-4">
                <h4>Total: <span style="color: #ff7f8a;">Rs <%= totalPrice %></span></h4>
                <a href="cakes.jsp" class="btn btn-soft">Continue Shopping</a>
                <form action="CheckoutServlet" method="POST" style="display:inline;">
                    <button type="submit" class="btn btn-soft">Checkout</button>
                </form>
            </div>
        <%
            }
        %>
    </div>

    <!-- Footer -->
    <footer>
        <p>© 2025 Sweet Treats Bakery | Made with ❤️ by Sweet Treats Team</p>
    </footer>

    <!-- Bootstrap Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>