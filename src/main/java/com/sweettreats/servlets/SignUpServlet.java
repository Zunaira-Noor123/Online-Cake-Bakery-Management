package com.sweettreats.servlets;

import com.sweettreats.utils.utils; // Import utils for database connection
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String email = request.getParameter("email").trim(); // Email may be empty

        System.out.println("DEBUG: Username: " + username);
        System.out.println("DEBUG: Password: " + password);
        System.out.println("DEBUG: Email: " + email);

        // Validate mandatory fields
        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("message", "Username and password are required.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Validate optional email
        email = email.isEmpty() ? null : email;

        // SQL query to insert new user
        String query = "INSERT INTO Users (username, password, email) VALUES (?, ?, ?)";

        try (Connection conn = utils.getConnection()) {
            System.out.println("DEBUG: Connected to the database for signup.");

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password); // You can hash this for security
            ps.setString(3, email);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("DEBUG: Signup successful for user: " + username);
                response.sendRedirect("login.jsp?signup=success");
            } else {
                System.out.println("DEBUG: Signup failed!");
                request.setAttribute("message", "Signup failed. Please try again.");
                request.getRequestDispatcher("/signup.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL exception occurred during signup.");
            request.setAttribute("message", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            e.printStackTrace();
        }
    }
}