<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    String email = (String) session.getAttribute("email");

    if (role == null || !"delivery".equals(role)) {
        response.sendRedirect("deliveryLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery Dashboard | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6ea, #ffd6e0, #ffc2d1);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.dashboard-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(12px);
    border-radius: 25px;
    padding: 40px 30px;
    max-width: 700px;
    width: 100%;
    text-align: center;
    box-shadow: 0 8px 30px rgba(231,84,128,0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.dashboard-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 40px rgba(231,84,128,0.3);
}

.header {
    color: #e75480;
    font-weight: 700;
    font-size: 2rem;
    margin-bottom: 15px;
}

.dashboard-card p {
    color: #6c4a5c;
    margin-bottom: 30px;
    font-size: 1.1rem;
}

/* Stats Cards */
.stats-container {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    margin-bottom: 30px;
}

.stats-card {
    flex: 1 1 150px;
    background: #fff0f3;
    border-radius: 20px;
    margin: 10px;
    padding: 20px;
    box-shadow: 0 5px 15px rgba(231,84,128,0.15);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stats-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(231,84,128,0.25);
}

.stats-card i {
    font-size: 1.8rem;
    color: #e75480;
    margin-bottom: 10px;
}

.stats-card h3 {
    font-size: 1.5rem;
    margin-bottom: 5px;
    color: #6c4a5c;
}

.stats-card p {
    color: #9c7b86;
    font-size: 0.95rem;
}

/* Buttons */
.btn-action {
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: #fff;
    border: none;
    border-radius: 50px;
    padding: 12px 25px;
    font-weight: 600;
    margin: 10px;
    transition: all 0.3s ease;
}

.btn-action:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(232,92,143,0.35);
}

.btn-logout {
    background: linear-gradient(90deg, #ea5353, #d32f2f);
    color: white;
    border: none;
    border-radius: 50px;
    padding: 12px 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-logout:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(220,53,69,0.35);
}
</style>
</head>
<body>

<div class="dashboard-card">
    <h1 class="header">Welcome, <%= (email != null ? email : "Delivery User") %>!</h1>
    <p>Manage your deliveries efficiently with your dashboard.</p>

    <div class="stats-container">
        <div class="stats-card">
            <i class="fa-solid fa-clock"></i>
            <h3>12</h3>
            <p>Pending Deliveries</p>
        </div>
        <div class="stats-card">
            <i class="fa-solid fa-truck"></i>
            <h3>5</h3>
            <p>In-Progress</p>
        </div>
        <div class="stats-card">
            <i class="fa-solid fa-check-circle"></i>
            <h3>20</h3>
            <p>Completed</p>
        </div>
    </div>

    <a href="ViewPendingDeliveriesServlet" class="btn btn-action"><i class="fa-solid fa-list-check me-1"></i> View Pending Deliveries</a>
    <a href="DeliveryLogoutServlet" class="btn btn-logout"><i class="fa-solid fa-right-from-bracket me-1"></i> Logout</a>
</div>

</body>
</html>
