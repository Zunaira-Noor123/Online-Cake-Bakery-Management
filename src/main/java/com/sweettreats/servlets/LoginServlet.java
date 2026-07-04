package com.sweettreats.servlets;

import com.sweettreats.utils.utils; // Import utils for database connection
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve username and password from the login form
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        System.out.println("DEBUG: Username received: '" + username + "'");
        System.out.println("DEBUG: Password received: '" + password + "'");

        // SQL query to fetch user details, including role
        String query = "SELECT id, role FROM Users WHERE LOWER(username) = LOWER(?) AND password = ?";

        try (Connection conn = utils.getConnection()) { // Using utils for database connection
            System.out.println("DEBUG: Database connection established!");

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id");
                String role = rs.getString("role");
                System.out.println("DEBUG: Login successful! User ID = " + userId);
                System.out.println("DEBUG: Role = " + role);

                // Start session and store user information
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Set session timeout to 30 minutes
                session.setMaxInactiveInterval(30 * 60);

                // Redirect to role-specific dashboard
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else if ("delivery".equalsIgnoreCase(role)) {
                    response.sendRedirect("deliveryDashboard.jsp");
                } else {
                    response.sendRedirect("cakes.jsp"); // Redirect to user view
                }
            } else {
                System.out.println("DEBUG: Login failed!");
                request.setAttribute("message", "Invalid username or password.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL exception occurred.");
            e.printStackTrace();
            request.setAttribute("message", "An error occurred. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}