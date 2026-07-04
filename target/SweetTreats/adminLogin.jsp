<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #ffe6eb, #ffd6e0, #ffc2d1);
    margin: 0;
}

.login-card {
    background: #fff0f3;
    border-radius: 25px;
    padding: 40px 35px;
    max-width: 420px;
    width: 100%;
    box-shadow: 0 8px 25px rgba(231, 84, 128, 0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    animation: fadeUp 0.9s ease;
}

.login-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(231, 84, 128, 0.3);
}

h2 {
    text-align: center;
    font-weight: 700;
    color: #e75480;
    margin-bottom: 25px;
}

.input-group-text {
    background: #ffc2d1;
    border: none;
    border-radius: 12px 0 0 12px;
    color: #e75480;
}

.form-control {
    border-radius: 0 12px 12px 0;
    border: 2px solid #ffc2d1;
    padding: 10px 12px;
    box-shadow: inset 0 2px 5px rgba(255,198,203,0.2);
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #e85c8f;
    box-shadow: 0 0 8px rgba(232,92,143,0.2);
    outline: none;
}

.btn-custom {
    width: 100%;
    margin-top: 20px;
    padding: 12px;
    font-size: 1.05rem;
    font-weight: 600;
    border-radius: 50px;
    border: none;
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: #fff;
    box-shadow: 0 8px 20px rgba(232,92,143,0.35);
    transition: all 0.3s ease;
}

.btn-custom:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(232,92,143,0.45);
}

.text-danger, .text-success {
    text-align: center;
    font-size: 0.95rem;
    font-weight: 600;
    margin-bottom: 15px;
}

.text-danger { color: #e63946; }
.text-success { color: #52b788; }

footer {
    margin-top: 25px;
    text-align: center;
    font-size: 0.8rem;
    color: #9c7b86;
}

@keyframes fadeUp {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

@media (max-width: 576px) {
    .input-group { flex-direction: column; }
    .input-group-text, .form-control { border-radius: 12px; }
}
</style>
</head>
<body>

<div class="login-card">
    <h2>Admin Login</h2>

    <%-- Error Message --%>
    <% if (request.getAttribute("error") != null) { %>
        <div class="text-danger">Invalid username or password. Please try again.</div>
    <% } %>

    <%-- Success Message --%>
    <% if (request.getAttribute("success") != null && "logout".equals(request.getAttribute("success"))) { %>
        <div class="text-success">You have successfully logged out.</div>
    <% } %>

    <form action="AdminLoginServlet" method="POST" onsubmit="return validateForm()">
        <div class="mb-3">
            <label for="adminUsername">Admin Username</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                <input type="text" id="adminUsername" name="adminUsername" class="form-control" placeholder="Enter username" required>
            </div>
        </div>

        <div class="mb-3">
            <label for="adminPassword">Admin Password</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                <input type="password" id="adminPassword" name="adminPassword" class="form-control" placeholder="Enter password" required>
            </div>
        </div>

        <button type="submit" class="btn-custom"><i class="fa-solid fa-right-to-bracket me-1"></i> Log In</button>
    </form>

    <footer>
        &copy; 2025 Sweet Treats Bakery
    </footer>
</div>

<script>
function validateForm() {
    const username = document.getElementById("adminUsername").value.trim();
    const password = document.getElementById("adminPassword").value.trim();
    if (!username || !password) {
        alert("Both username and password fields are required.");
        return false;
    }
    return true;
}
</script>

</body>
</html>
