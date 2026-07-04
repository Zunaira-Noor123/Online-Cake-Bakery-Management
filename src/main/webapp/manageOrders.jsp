<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Orders | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #ffe6eb, #ffd6e0, #ffc2d1);
        min-height: 100vh;
        padding: 40px 20px;
    }

    /* Decorative blobs */
    .blob {
        position: absolute;
        border-radius: 50%;
        filter: blur(80px);
        opacity: 0.5;
        z-index: 0;
    }
    .blob1 { width: 300px; height: 300px; background: #ff9eb5; top: -50px; left: -50px; }
    .blob2 { width: 400px; height: 400px; background: #ffb3c6; bottom: -100px; right: -100px; }

    h2 {
        text-align: center;
        color: #e75480;
        font-weight: 700;
        margin-bottom: 50px;
        position: relative;
        z-index: 1;
    }

    /* Order card */
    .order-card {
        background: rgba(255, 245, 247, 0.95);
        border-radius: 20px;
        box-shadow: 0 15px 30px rgba(231,84,128,0.15);
        padding: 25px;
        margin-bottom: 30px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        position: relative;
        z-index: 1;
    }
    .order-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(231,84,128,0.25);
    }

    /* Order info */
    .order-info {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        margin-bottom: 12px;
        font-size: 0.95rem;
        color: #6c4a5c;
        background: #fff0f2;
        padding: 10px 15px;
        border-radius: 12px;
    }

    .order-info strong {
        color: #e75480;
        margin-right: 5px;
    }

    .order-info span {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    /* Delete button */
    .btn-danger {
        background: linear-gradient(90deg, #f08091, #dc3545);
        border: none;
        border-radius: 50px;
        padding: 6px 20px;
        font-weight: 600;
        color: white;
        transition: all 0.3s ease;
        margin-top: 5px;
    }
    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(220,53,69,0.4);
    }

    /* Back button */
    .btn-back {
        display: inline-block;
        margin: 30px auto 10px auto;
        background: linear-gradient(90deg, #f8a1b3, #e75480);
        color: white;
        padding: 12px 35px;
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
        .order-info { flex: 1 1 100%; margin-bottom: 8px; }
    }
</style>
</head>
<body>

<!-- Decorative Blobs -->
<div class="blob blob1"></div>
<div class="blob blob2"></div>

<h2>Manage Orders</h2>

<div class="container">
<%
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sweettreatsdb", "root", "zunaira_noor786")) {
        String query = "SELECT o.id AS order_id, o.user_id, o.total_price, o.created_at, " +
                       "c.name AS cake_name, oi.quantity, oi.price " +
                       "FROM Orders o " +
                       "JOIN OrderItems oi ON o.id = oi.order_id " +
                       "JOIN Cakes c ON oi.cake_id = c.id " +
                       "ORDER BY o.created_at DESC";

        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
%>
    <div class="order-card">
        <div class="order-info"><span>🆔 <strong>Order ID:</strong> <%= rs.getInt("order_id") %></span></div>
        <div class="order-info"><span>👤 <strong>User ID:</strong> <%= rs.getInt("user_id") %></span></div>
        <div class="order-info"><span>📅 <strong>Created At:</strong> <%= rs.getTimestamp("created_at") %></span></div>
        <div class="order-info"><span>🍰 <strong>Cake:</strong> <%= rs.getString("cake_name") %></span></div>
        <div class="order-info"><span>📦 <strong>Quantity:</strong> <%= rs.getInt("quantity") %></span></div>
        <div class="order-info"><span>💵 <strong>Price:</strong> Rs <%= rs.getDouble("price") %></span></div>
        <div class="order-info"><span>🛒 <strong>Total:</strong> Rs <%= rs.getDouble("total_price") %></span></div>

        <div style="text-align:center;">
            <form action="ManageOrdersServlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this order?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="orderId" value="<%= rs.getInt("order_id") %>">
                <button type="submit" class="btn-danger">Delete</button>
            </form>
        </div>
    </div>
<% } } catch (SQLException e) { e.printStackTrace(); } %>

<!-- Back Button -->
<div class="text-center">
    <a href="adminDashboard.jsp" class="btn-back">Back to Dashboard</a>
</div>
</div>

</body>
</html>
