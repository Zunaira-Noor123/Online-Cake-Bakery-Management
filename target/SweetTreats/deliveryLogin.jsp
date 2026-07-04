<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Delivery Login | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6eb, #ffd6e0);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
    margin: 0;
}

.login-card {
    background: #fff0f3;
    border-radius: 25px;
    padding: 35px 30px;
    box-shadow: 0 8px 25px rgba(231,84,128,0.2);
    max-width: 400px;
    width: 100%;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    animation: fadeIn 0.8s ease-in-out;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.login-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(231,84,128,0.3);
}

.login-card h1 {
    text-align: center;
    color: #e75480;
    font-weight: 700;
    margin-bottom: 25px;
    position: relative;
}

.login-card h1::after {
    content: "";
    display: inline-block;
    width: 60px;
    height: 4px;
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    border-radius: 2px;
    margin: 10px auto;
    display: block;
}

.input-group-text {
    background: #ffc2d1;
    color: #e75480;
    border: none;
    border-radius: 12px 0 0 12px;
}

.form-control {
    border-radius: 0 12px 12px 0;
    border: 1.8px solid #ffc2d1;
    padding: 12px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #e85c8f;
    box-shadow: 0 0 5px rgba(232,92,143,0.3);
    outline: none;
}

.btn-submit {
    display: block;
    width: 100%;
    padding: 12px 25px;
    margin-top: 20px;
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: white;
    font-weight: 600;
    font-size: 1rem;
    border: none;
    border-radius: 30px;
    box-shadow: 0 5px 15px rgba(232,92,143,0.3);
    transition: all 0.3s ease;
}

.btn-submit:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(232,92,143,0.5);
}

.form-error {
    color: #d9534f;
    text-align: center;
    font-size: 0.9rem;
    margin-top: 15px;
}

.footer-text {
    margin-top: 15px;
    text-align: center;
    font-size: 0.85rem;
    color: #6a6a6a;
}

.footer-link {
    color: #e75480;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.footer-link:hover {
    text-decoration: underline;
    color: #d32f2f;
}
</style>
</head>
<body>

<div class="login-card">
    <h1>Delivery Login</h1>
    <form action="DeliveryLoginServlet" method="POST">
        <!-- Username Input -->
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
            </div>
        </div>

        <!-- Password Input -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
            </div>
        </div>

        <!-- Error Message -->
        <% if (request.getParameter("error") != null) { %>
            <p class="form-error">Invalid username or password. Please try again.</p>
        <% } %>

        <!-- Submit Button -->
        <button type="submit" class="btn-submit">Log In</button>
    </form>

    <!-- Footer -->
    <p class="footer-text">
        Forgot your credentials? <a href="passwordRecovery.jsp" class="footer-link">Recover Password</a>
    </p>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
