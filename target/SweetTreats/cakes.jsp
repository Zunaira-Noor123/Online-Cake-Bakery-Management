<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sweettreats.model.Cake" %>
<%@ page import="com.sweettreats.dao.CakeDAO" %>

<%
    CakeDAO dao = new CakeDAO();

    String search = request.getParameter("search");
    String minPrice = request.getParameter("min");
    String maxPrice = request.getParameter("max");

    List<Cake> cakes;

    if (search != null && !search.trim().isEmpty()) {
        cakes = dao.searchCakes(search);
    } else if (minPrice != null && maxPrice != null &&
               !minPrice.trim().isEmpty() && !maxPrice.trim().isEmpty()) {

        double min = Double.parseDouble(minPrice);
        double max = Double.parseDouble(maxPrice);
        cakes = dao.getCakesByPrice(min, max);

    } else {
        cakes = dao.getAllCakes();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Our Cakes | Sweet Treats Bakery</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

<!-- Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

/* 🌸 BACKGROUND */
body {
    font-family: 'Poppins', sans-serif;
    background:
        radial-gradient(circle at 10% 10%, #ffe0eb, transparent 35%),
        radial-gradient(circle at 90% 90%, #fff0f6, transparent 40%),
        linear-gradient(135deg, #fff6fa, #ffffff);
}

/* ✨ SPARKLES */
.sparkle {
    position: fixed;
    width: 6px;
    height: 6px;
    background: #ff9eb3;
    border-radius: 50%;
    opacity: .6;
    animation: float 6s infinite ease-in-out;
}
.sparkle:nth-child(1){ top:20%; left:10%; }
.sparkle:nth-child(2){ top:60%; left:20%; animation-delay:2s; }
.sparkle:nth-child(3){ top:40%; left:80%; animation-delay:4s; }

@keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-25px); }
    100% { transform: translateY(0); }
}

/* 🍭 NAVBAR */
.navbar {
    background: linear-gradient(270deg, #ff7fa2, #ffb3c6, #ff7fa2);
    background-size: 400% 400%;
    animation: gradientMove 8s ease infinite;
    box-shadow: 0 10px 30px rgba(255,160,190,.45);
}

@keyframes gradientMove {
    0%{background-position:0%}
    50%{background-position:100%}
    100%{background-position:0%}
}

.navbar-brand {
    font-family: 'Pacifico', cursive;
    font-size: 2.3rem;
    color: white !important;
}

.nav-link {
    color: white !important;
}

/* 🎀 DASHBOARD BUTTON */
.dashboard-btn {
    background: white;
    color: #ff6f91;
    border-radius: 30px;
    padding: 7px 22px;
    font-weight: 600;
}

/* 🔍 SEARCH BAR ON TOP */
.search-area {
    margin-top: 25px;
    margin-bottom: 20px;
}

.search-box {
    background: white;
    border-radius: 40px;
    padding: 8px;
    box-shadow: 0 12px 30px rgba(255,150,190,.45);
}

.search-input {
    border: none;
    border-radius: 40px;
    padding: 14px 20px;
}

.search-btn {
    background: linear-gradient(90deg,#ff8fab,#ffb3c6);
    border-radius: 40px;
    color: white;
    border: none;
    padding: 0 22px;
}

/* 🍰 HEADING */
h2 {
    font-family: 'Pacifico', cursive;
    color: #ff6f91;
    text-align: center;
    font-size: 3rem;
    margin: 0px 0 20px;
}

/* 💎 CARD */
.card {
    border: none;
    border-radius: 28px;
    box-shadow: 0 20px 45px rgba(255,170,200,.45);
    transition: .4s;
}

.card:hover {
    transform: translateY(-12px);
}

.card-img-top {
    height: 230px;
    object-fit: cover;
    border-radius: 28px 28px 0 0;
}

.card-title {
    color: #ff6f91;
    font-weight: 600;
}

.price {
    font-size: 1.3rem;
    color: #ff6f91;
    font-weight: bold;
}

/* 💗 BUTTONS */
.btn-cart {
    background: linear-gradient(90deg,#ff8fab,#ffb3c6);
    color: white;
    border-radius: 30px;
    padding: 9px 22px;
    border: none;
}

/* 🌸 FOOTER */
footer {
    background: linear-gradient(90deg,#ffe0eb,#fff);
    padding: 25px;
    margin-top: 80px;
    text-align: center;
    color: #777;
}

/* 🔥 SIDEBAR DRAWER */
.drawer {
    position: fixed;
    top: 0;
    left: -360px;
    width: 360px;
    height: 100%;
    background: rgba(255,255,255,0.95);
    box-shadow: 0 25px 60px rgba(255,160,190,.55);
    padding: 30px;
    transition: 0.4s;
    z-index: 1000;
    overflow-y: auto;
}

.drawer.open {
    left: 0;
}

.drawer h4 {
    color: #ff6f91;
    font-weight: 700;
    margin-bottom: 15px;
}

.drawer .line {
    height: 2px;
    background: #ffb3c6;
    margin: 10px 0 20px;
}

.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.45);
    display: none;
    z-index: 999;
}

.overlay.open {
    display: block;
}
</style>
</head>

<body>

<div class="sparkle"></div>
<div class="sparkle"></div>
<div class="sparkle"></div>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark">
<div class="container-fluid">
    <a class="navbar-brand" href="#">
        <i class="fa-solid fa-cake-candles"></i> Sweet Treats
    </a>

    <button class="btn btn-cart" id="openDrawer">
        <i class="fa-solid fa-filter"></i> Filters
    </button>

    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item">
                <a class="nav-link" href="cakes.jsp">Cakes</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="cart.jsp">Cart</a>
            </li>
            <li class="nav-item ms-2">
                <a href="Dashboard.jsp" class="dashboard-btn">Dashboard</a>
            </li>
        </ul>
    </div>
</div>
</nav>

<!-- SEARCH BAR -->
<div class="container search-area">
    <form method="get" action="cakes.jsp" class="search-box d-flex">
        <input type="text" name="search"
               class="form-control search-input"
               placeholder="Search your dream cake 🍓"
               value="<%= search != null ? search : "" %>">
        <button class="btn search-btn">
            <i class="fa-solid fa-magnifying-glass"></i> Search
        </button>
    </form>
</div>

<!-- SIDEBAR DRAWER -->
<div class="drawer" id="drawer">
    <h4><i class="fa-solid fa-filter"></i> Filters</h4>
    <div class="line"></div>

    <form method="get" action="cakes.jsp">
        <div class="mb-3">
            <label class="form-label">Min Price</label>
            <input type="number" name="min" class="form-control"
                   value="<%= minPrice != null ? minPrice : "" %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Max Price</label>
            <input type="number" name="max" class="form-control"
                   value="<%= maxPrice != null ? maxPrice : "" %>">
        </div>

        <button class="btn btn-cart w-100">
            Apply Filters
        </button>
    </form>
</div>

<div class="overlay" id="overlay"></div>

<!-- CONTENT -->
<div class="container">
<h2>Where Every Cake Feels Like Magic ✨</h2>

<div class="row row-cols-1 row-cols-md-3 g-4">
<% if (cakes.isEmpty()) { %>
    <p class="text-center text-muted fs-5">No cakes found 🍰</p>
<% } %>

<% for (Cake c : cakes) { %>
<div class="col">
    <div class="card h-100">
        <img src="<%= c.getImageUrl() %>" class="card-img-top">
        <div class="card-body text-center">
            <h5 class="card-title"><%= c.getName() %></h5>
            <p><%= c.getDescription() %></p>
            <p class="price">Rs <%= c.getPrice() %></p>

            <div class="d-flex justify-content-center gap-2">
                <a href="AddToCartServlet?cakeId=<%= c.getId() %>" class="btn btn-cart">
                    <i class="fa-solid fa-cart-plus"></i> Add
                </a>
                <a href="CakeDetailsServlet?cakeId=<%= c.getId() %>" class="btn btn-outline-secondary">
                    View
                </a>
            </div>
        </div>
    </div>
</div>
<% } %>
</div>
</div>

<footer>
    Made with <i class="fa-solid fa-heart"></i> © 2025 Sweet Treats Bakery
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const drawer = document.getElementById("drawer");
    const overlay = document.getElementById("overlay");
    const openBtn = document.getElementById("openDrawer");

    openBtn.addEventListener("click", function() {
        drawer.classList.add("open");
        overlay.classList.add("open");
    });

    overlay.addEventListener("click", function() {
        drawer.classList.remove("open");
        overlay.classList.remove("open");
    });
</script>
</body>
</html>
