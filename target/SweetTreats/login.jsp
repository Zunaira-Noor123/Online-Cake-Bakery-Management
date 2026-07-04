<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login | Sweet Treats Bakery</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6ea, #ffd6e0, #ffc2d1);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
}
/* Card */
.login-card {
    background: rgba(255,255,255,0.96);
    backdrop-filter: blur(12px);
    border-radius: 30px;
    padding: 45px 35px;
    max-width: 420px;
    width: 100%;
    box-shadow: 0 20px 45px rgba(231,84,128,0.35);
    text-align: center;
    animation: fadeUp 0.8s ease;
}
/* Header */
.login-header {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 15px;
}
.login-header i {
    font-size: 2.8rem;
    color: #ff7f8a;
    margin-right: 10px;
}
.login-header span {
    font-size: 1.9rem;
    font-weight: 700;
    color: #e75480;
}

h2 {
    font-size: 1.4rem;
    color: #7b6f73;
    margin-bottom: 25px;
}
/* Input box */
.input-box {
    position: relative;
    margin-bottom: 18px;
}
.input-box input {
    width: 100%;
    padding: 14px 52px;
    border-radius: 30px;
    border: 1px solid #f3c1d1;
    background: #f4f8ff;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}
.input-box input:focus {
    border-color: #ff7f8a;
    box-shadow: 0 0 15px rgba(255,127,138,0.35);
    outline: none;
}
/* Left icons */
.left-icon {
    position: absolute;
    left: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: #ff7f8a;
    font-size: 1rem;
}

/* Right eye icon */
.right-icon {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: #ff7f8a;
    font-size: 1.05rem;
    cursor: pointer;
    transition: 0.3s;
}
.right-icon:hover {
    color: #e75480;
    transform: translateY(-50%) scale(1.15);
}
/* Buttons */
.btn-login, .btn-signup {
    width: 48%;
    padding: 12px 0;
    border-radius: 50px;
    font-weight: 600;
    border: none;
    color: white;
    transition: 0.3s ease;
    text-decoration: none;
}
.btn-login {
    background: linear-gradient(90deg, #e75480, #f18ca8);
}

.btn-login:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 25px rgba(231,84,128,0.45);
}

.btn-signup {
    background: linear-gradient(90deg, #ffa07a, #ff7f8a);
}

.btn-signup:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 25px rgba(255,127,138,0.45);
}
/* Messages */
.alert, .text-danger {
    border-radius: 15px;
    font-size: 0.9rem;
    font-weight: 600;
}
.footer {
    margin-top: 25px;
    font-size: 0.85rem;
    color: #9c7b86;
}

/* Animation */
@keyframes fadeUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>

</head>
<body>

<div class="login-card">

    <!-- Logo -->
    <div class="login-header">
        <i class="fa-solid fa-cake-candles"></i>
        <span>Sweet Treats</span>
    </div>

    <h2>Welcome Back</h2>

    <!-- Error Alerts -->
    <% if (request.getAttribute("message") != null) { %>
        <div class="text-danger mb-3">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <!-- Form -->
    <form action="LoginServlet" method="POST">

        <!-- Username -->
        <div class="input-box">
            <i class="fa-solid fa-user left-icon"></i>
            <input type="text" id="username" name="username" placeholder="Username" required>
        </div>

        <!-- Password -->
        <div class="input-box">
            <i class="fa-solid fa-lock left-icon"></i>
            <input type="password" id="password" name="password" placeholder="Password" required>
            <i class="fa-solid fa-eye right-icon"
               onclick="
                const p=document.getElementById('password');
                this.classList.toggle('fa-eye-slash');
                p.type = p.type === 'password' ? 'text' : 'password';
               ">
            </i>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn-login">Log In</button>
            <a href="signup.jsp" class="btn-signup">Sign Up</a>
        </div>
    </form>

    <div class="footer">
        &copy; 2025 Sweet Treats Bakery
    </div>
</div>

</body>
</html>