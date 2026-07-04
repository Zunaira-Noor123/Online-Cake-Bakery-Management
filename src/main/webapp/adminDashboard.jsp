<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");

    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Sweet Treats Bakery</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #ffe6eb, #ffd6e0, #ffc2d1);
            padding: 40px 20px;
        }

        .dashboard-container {
            max-width: 1100px;
            margin: auto;
        }

        /* Header */
        .header-card {
            background: rgba(255,255,255,0.95);
            border-radius: 28px;
            padding: 35px 40px;
            box-shadow: 0 25px 45px rgba(0,0,0,0.15);
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 45px;
            animation: fadeUp 0.8s ease;
        }

        .header-left h1 {
            color: #e75480;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .header-left p {
            color: #7b6f73;
            margin: 0;
        }

        .badge-admin {
            background: linear-gradient(90deg, #e75480, #f18ca8);
            color: #fff;
            padding: 10px 22px;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(231,84,128,0.4);
        }

        /* Feature Cards */
        .feature-card {
            background: rgba(255,255,255,0.96);
            border-radius: 24px;
            padding: 32px 28px;
            text-align: center;
            box-shadow: 0 18px 35px rgba(0,0,0,0.12);
            transition: all 0.35s ease;
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: "";
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(120deg, transparent, rgba(255,255,255,0.6), transparent);
            transition: 0.6s ease;
        }

        .feature-card:hover::before {
            left: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 28px 50px rgba(231,84,128,0.35);
        }

        .feature-icon {
            font-size: 2.6rem;
            color: #e75480;
            margin-bottom: 18px;
        }

        .feature-card h5 {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .feature-card p {
            font-size: 0.92rem;
            color: #7b6f73;
        }

        .feature-card a {
            display: inline-block;
            margin-top: 18px;
            padding: 11px 30px;
            border-radius: 50px;
            background: linear-gradient(90deg, #e75480, #f18ca8);
            color: white;
            text-decoration: none;
            font-weight: 600;
            box-shadow: 0 10px 22px rgba(231,84,128,0.35);
            transition: 0.3s ease;
        }

        .feature-card a:hover {
            box-shadow: 0 15px 32px rgba(231,84,128,0.5);
        }

        /* Logout */
        .logout-btn {
            margin-top: 50px;
            display: inline-block;
            padding: 14px 45px;
            border-radius: 50px;
            background: linear-gradient(90deg, #ff6b6b, #e63946);
            color: white;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 12px 28px rgba(230,57,70,0.45);
            transition: 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 18px 38px rgba(230,57,70,0.6);
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="dashboard-container">

    <!-- Header -->
    <div class="header-card">
        <div class="header-left">
            <h1>Hello, <%= username != null ? username : "Admin" %> 👋</h1>
            <p>Welcome back! Let’s keep Sweet Treats running smoothly 🍰</p>
        </div>
        <div class="badge-admin">
            <i class="fa-solid fa-shield-halved"></i> Admin Mode
        </div>
    </div>

    <!-- Features -->
    <div class="row g-4">
        <div class="col-md-6 col-lg-3">
            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-users"></i></div>
                <h5>Manage Users</h5>
                <p>Control customer and staff accounts easily.</p>
                <a href="manageUsers.jsp">Open</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-receipt"></i></div>
                <h5>Manage Orders</h5>
                <p>Track and process bakery orders smoothly.</p>
                <a href="manageOrders.jsp">Open</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-cake-candles"></i></div>
                <h5>Manage Cakes</h5>
                <p>Add and update delicious cake items.</p>
                <a href="manageCakes.jsp">Open</a>
            </div>
        </div>

        <div class="col-md-6 col-lg-3">
            <div class="feature-card">
                <div class="feature-icon"><i class="fa-solid fa-truck"></i></div>
                <h5>Manage Deliveries</h5>
                <p>Assign and track delivery operations.</p>
                <a href="manageDeliveries.jsp">Open</a>
            </div>
        </div>
    </div>

    <!-- Logout -->
    <div class="text-center">
        <a href="AdminLogoutServlet" class="logout-btn">Logout</a>
    </div>

</div>

</body>
</html>
