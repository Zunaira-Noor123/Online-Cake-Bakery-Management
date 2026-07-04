<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    String username = "";
    String email = "";

    try (Connection conn = com.sweettreats.utils.utils.getConnection()) {
        String query = "SELECT username, email FROM Users WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            username = rs.getString("username");
            email = rs.getString("email");
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
<title>Edit User | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #ffe6eb, #ffd6e0);
    padding: 50px 20px;
}

h2 {
    text-align: center;
    color: #e75480;
    font-weight: 700;
    margin-bottom: 15px;
    position: relative;
}

h2::after {
    content: "";
    width: 80px;
    height: 4px;
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    display: block;
    margin: 8px auto 0;
    border-radius: 2px;
}

.form-card {
    background: #fff0f3;
    border-radius: 25px;
    padding: 35px 25px;
    max-width: 500px;
    margin: auto;
    box-shadow: 0 8px 25px rgba(231,84,128,0.2);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.form-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(231,84,128,0.3);
}

.input-group-text {
    background: #ffc2d1;
    border: none;
    border-radius: 12px 0 0 12px;
    color: #e75480;
}

.form-label {
    font-weight: 600;
    color: #6c4a5c;
}

.form-control {
    border-radius: 0 12px 12px 0;
    border: 2px solid #ffc2d1;
    padding: 10px 12px;
    transition: all 0.3s ease;
    box-shadow: inset 0 2px 5px rgba(255,198,203,0.2);
}

.form-control:focus {
    border-color: #e85c8f;
    box-shadow: 0 0 8px rgba(232,92,143,0.2);
    outline: none;
}

.btn {
    border-radius: 50px;
    padding: 10px 25px;
    font-weight: 600;
    transition: all 0.3s ease;
    margin-right: 10px;
}

.btn-save {
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: white;
    border: none;
}

.btn-save:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(232,92,143,0.4);
}

.btn-cancel {
    background: linear-gradient(90deg, #ffc107, #e0a800);
    color: white;
    border: none;
}

.btn-cancel:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(224,168,0,0.4);
}

@media (max-width: 576px) {
    .form-card {
        padding: 25px 15px;
    }
    .btn {
        width: 100%;
        margin-bottom: 10px;
    }
    .input-group {
        flex-direction: column;
    }
    .input-group-text, .form-control {
        border-radius: 12px;
    }
}
</style>
</head>
<body>

<div class="form-card">
    <h2>Edit User Details</h2>
    <form action="ManageUsersServlet" method="POST">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="userId" value="<%= userId %>">

        <div class="mb-4">
            <label for="username" class="form-label">Username:</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                <input type="text" id="username" name="username" class="form-control" value="<%= username %>" required>
            </div>
        </div>

        <div class="mb-4">
            <label for="email" class="form-label">Email:</label>
            <div class="input-group">
                <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                <input type="email" id="email" name="email" class="form-control" value="<%= email %>" required>
            </div>
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-save"><i class="fa-solid fa-floppy-disk me-1"></i> Save Changes</button>
            <a href="manageUsers.jsp" class="btn btn-cancel"><i class="fa-solid fa-xmark me-1"></i> Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
