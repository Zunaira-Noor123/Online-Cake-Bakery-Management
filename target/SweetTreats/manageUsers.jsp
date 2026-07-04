<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Users | Sweet Treats Bakery</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #ffe6eb; /* soft pink background */
    padding: 40px 20px;
}

h2 {
    color: #e75480;
    text-align: center;
    margin-bottom: 30px;
    font-weight: 700;
}

.table-container {
    max-width: 1000px;
    margin: auto;
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 10px;
}

thead th {
    background: white;
    color: #e75480;
    font-weight: 600;
    padding: 12px 15px;
    border-radius: 15px;
    border: 1px solid #ffc2d1;
    text-align: center;
}

tbody td {
    background: white;
    color: #6c4a5c;
    font-weight: 500;
    padding: 12px 10px;
    border-radius: 12px;
    border: 1px solid #ffc2d1;
    text-align: center;
    vertical-align: middle;
}

tbody tr:hover td {
    background: #ffe6eb;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(231,84,128,0.2);
    transition: all 0.2s ease;
}

.btn {
    border-radius: 50px;
    padding: 6px 15px;
    font-weight: 600;
    transition: all 0.3s ease;
    font-size: 0.85rem;
    cursor: pointer;
    margin: 2px 0;
}

.btn-primary {
    background: linear-gradient(90deg, #f5b0c1, #e85c8f);
    color: white;
    border: none;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(232,92,143,0.4);
}

.btn-danger {
    background: linear-gradient(90deg, #f08091, #dc3545);
    color: white;
    border: none;
}

.btn-danger:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(220,53,69,0.4);
}

.btn-back {
    display: inline-block;
    margin-top: 20px;
    background: linear-gradient(90deg, #f8a1b3, #e75480);
    color: white;
    padding: 10px 30px;
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
    table, thead, tbody, th, td, tr {
        display: block;
    }
    thead tr {
        display: none;
    }
    tbody td {
        display: flex;
        justify-content: space-between;
        padding: 10px;
        margin-bottom: 10px;
        border-radius: 15px;
    }
    tbody td::before {
        content: attr(data-label);
        font-weight: 600;
        color: #e75480;
    }
}
</style>
</head>
<body>

<h2>Manage Users</h2>

<div class="table-container">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                try (Connection conn = com.sweettreats.utils.utils.getConnection()) {
                    String query = "SELECT id, username, email FROM Users ORDER BY created_at DESC";
                    PreparedStatement ps = conn.prepareStatement(query);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) { 
            %>
                <tr>
                    <td data-label="ID"><%= rs.getInt("id") %></td>
                    <td data-label="Username"><%= rs.getString("username") %></td>
                    <td data-label="Email"><%= rs.getString("email") %></td>
                    <td data-label="Actions">
                        <button type="button" class="btn btn-primary" onclick="window.location.href='editUser.jsp?userId=<%= rs.getInt("id") %>';">Update</button>
                        <form action="ManageUsersServlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this user?');" style="display:inline-block;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="userId" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
            <% 
                    } 
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>

<div class="text-center">
    <a href="adminDashboard.jsp" class="btn-back">Back to Dashboard</a>
</div>

</body>
</html>
