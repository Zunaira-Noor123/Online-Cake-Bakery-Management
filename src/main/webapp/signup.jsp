<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Nunito:wght@300;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Nunito', sans-serif;
    background: linear-gradient(180deg, #fff7f9 0%, #ffe6ea 100%);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
}

/* Signup Card */
.signup-card {
    background: linear-gradient(145deg, #fff0f3, #ffe0e6);
    padding: 45px 35px;
    border-radius: 30px;
    box-shadow: 0 15px 40px rgba(255,127,138,0.3);
    max-width: 400px;
    width: 100%;
    text-align: center;
}

/* Heading */
h2 {
    font-family: 'Pacifico', cursive;
    font-size: 2.5rem;
    color: #ff6f85;
    margin-bottom: 30px;
    text-shadow: 1px 1px 4px rgba(255,111,133,0.4);
}

/* Input group with icon */
.input-group {
    display: flex;
    align-items: center;
    background: #fff6f8;
    border-radius: 25px;
    padding: 12px 15px;
    margin-bottom: 20px;
    border: 2px solid #ffb6c1;
    transition: all 0.3s ease;
}

.input-group:hover {
    border-color: #ff6f85;
    box-shadow: 0 0 12px rgba(255,111,133,0.2);
}

.input-group i {
    font-size: 1.3rem;
    color: #ff6f85;
    margin-right: 10px;
    transition: 0.3s;
}

.input-group input {
    border: none;
    outline: none; /* remove blue outline */
    background: transparent;
    flex: 1;
    font-size: 1rem;
    color: #333;
}

/* Placeholder color */
.input-group input::placeholder {
    color: #ff6f85;
    opacity: 0.7;
}

/* Focus effect */
.input-group input:focus {
    outline: none; /* remove default focus outline */
    box-shadow: 0 0 10px rgba(255,111,133,0.3);
    border-color: #ff6f85;
}

/* Text selection color */
input::selection {
    background: #ffb6c1; /* pastel pink instead of blue */
    color: #fff;
}

/* Submit Button */
.btn-custom {
    background: linear-gradient(90deg, #ff6f85, #ff9ebc);
    color: white;
    border-radius: 50px;
    font-weight: bold;
    border: none;
    padding: 14px 0;
    font-size: 1.2rem;
    width: 100%;
    box-shadow: 0 8px 25px rgba(255,111,133,0.4);
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn-custom:hover {
    background: linear-gradient(90deg, #ff5170, #ff8ea0);
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(255,111,133,0.5);
}

.text-danger {
    font-weight: bold;
    color: #e63946;
    margin-bottom: 15px;
}

@media (max-width: 500px) {
    .signup-card {
        padding: 35px 20px;
    }
}
</style>
</head>
<body>
<div class="signup-card">
    <h2>Create Account</h2>
    <form action="SignUpServlet" method="POST">
        <!-- Username -->
        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required>
            <i class="fas fa-user"></i>
        </div>
        <!-- Password -->
        <div class="input-group">
            <input type="password" name="password" placeholder="Password" required>
            <i class="fas fa-lock"></i>
        </div>
        <!-- Email -->
        <div class="input-group">
            <input type="email" name="email" placeholder="Email (Optional)">
            <i class="fas fa-envelope"></i>
        </div>
        <!-- Error Message -->
        <% if (request.getAttribute("message") != null) { %>
            <div class="text-danger">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        <!-- Submit -->
        <button type="submit" class="btn-custom">Sign Up</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
