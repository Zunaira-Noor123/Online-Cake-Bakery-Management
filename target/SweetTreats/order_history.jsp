<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList,java.util.List" %>

<%
    // Retrieve user ID from session
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sweet Treats Bakery | Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(180deg, #ffe6ea 0%, #ffd3cb 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .welcome-card {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-weight: 600;
            color: #ff7f8a;
            margin-bottom: 20px;
        }

        p {
            color: #444;
            margin-bottom: 30px;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 8px;
            border: none;
            transition: 0.3s;
        }

        .btn-login {
            background-color: #ff7f8a;
            color: white;
            margin-right: 10px;
        }

        .btn-login:hover {
            background-color: #ff4f64;
            box-shadow: 0 5px 15px rgba(255, 127, 138, 0.3);
        }

        .btn-signup {
            background-color: #ffd3cb;
            color: black;
        }

        .btn-signup:hover {
            background-color: #ffe6ea;
            box-shadow: 0 5px 15px rgba(255, 211, 203, 0.3);
        }
    </style>
</head>
<body>
    <div class="welcome-card">
        <h1>Welcome to Sweet Treats Bakery!</h1>
        <p>Please log in or sign up to view your order history.</p>
        <a href="login.jsp" class="btn btn-login">Log In</a>
        <a href="signup.jsp" class="btn btn-signup">Sign Up</a>
    </div>
</body>
</html>
<%
        return;
    }

    // Database connection details
    String dbURL = "jdbc:mysql://localhost:3306/sweettreatsdb";
    String dbUser = "root";
    String dbPassword = "zunaira_noor786";

    List<String> orders = new ArrayList<>();

    try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword)) {
        String query = "SELECT o.id AS order_id, o.total_price, o.created_at, " +
                "c.name AS cake_name, oi.quantity, oi.price " +
                "FROM Orders o " +
                "JOIN OrderItems oi ON o.id = oi.order_id " +
                "JOIN Cakes c ON oi.cake_id = c.id " +
                "WHERE o.user_id = ? ORDER BY o.created_at DESC";

        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            orders.add("<div class='order-card'>" +
                       "<h5>Order ID: #" + rs.getInt("order_id") + "</h5>" +
                       "<p><i class='fas fa-cake'></i> <strong>Cake:</strong> " + rs.getString("cake_name") + "</p>" +
                       "<p><strong>Quantity:</strong> " + rs.getInt("quantity") + "</p>" +
                       "<p><strong>Price:</strong> Rs " + rs.getDouble("price") + "</p>" +
                       "<p><strong>Order Total:</strong> Rs " + rs.getDouble("total_price") + "</p>" +
                       "<small><strong>Ordered on:</strong> " + rs.getString("created_at") + "</small>" +
                       "</div>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History | Sweet Treats Bakery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(180deg, #fff7f9 0%, #ffe6ea 100%);
            margin: 0;
            padding: 0;
        }

        .hero {
            text-align: center;
            padding: 40px;
            background-color: #ffd3cb;
            color: #ff4f64;
            margin-bottom: 20px;
            border-radius: 0 0 50px 50px;
        }

        h1, h2 {
            font-weight: 600;
        }

        h1 {
            font-size: 32px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.08);
        }

        .order-card {
            background: #ffe6ea;
            border: 1px solid #ff7f8a;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 20px;
            box-shadow: 0px 5px 15px rgba(255, 127, 138, 0.2);
            transition: transform 0.3s, box-shadow 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-10px);
            box-shadow: 0px 10px 25px rgba(255, 127, 138, 0.3);
        }

        .btn-primary {
            display: block;
            width: fit-content;
            margin: 20px auto 0;
            background-color: #ff7f8a;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            color: white;
            font-weight: 600;
            box-shadow: 0px 5px 15px rgba(255, 127, 138, 0.3);
            transition: 0.3s ease-in-out;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            background-color: #e36376;
        }

        .no-orders {
            text-align: center;
            color: #888;
            font-size: 18px;
            font-weight: 500;
        }

        .no-orders i {
            font-size: 50px;
            color: #ff7f8a;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="hero">
        <h1>Welcome to Your Sweet Treats Journey!</h1>
        <p>See your past orders below or start shopping for new adventures.</p>
    </div>
    <div class="container">
        <h2>Order History</h2>
        <% if (orders.isEmpty()) { %>
            <div class="no-orders">
                <i class="fas fa-shopping-basket"></i>
                <p>You have no past orders. Start shopping to enjoy our sweet treats!</p>
            </div>
        <% } else { %>
            <% for (String order : orders) { %>
                <%= order %>
            <% } %>
        <% } %>
        <a href="cakes.jsp" class="btn btn-primary">Continue Shopping</a>
    </div>
</body>
</html>