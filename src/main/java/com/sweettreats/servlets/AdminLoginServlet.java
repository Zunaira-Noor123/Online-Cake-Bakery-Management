package com.sweettreats.servlets;

import com.sweettreats.utils.utils; // Import for database connection
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("adminUsername").trim();
        String password = request.getParameter("adminPassword").trim();

        System.out.println("DEBUG: Admin Username: " + username);

        // Hash the input password using SHA-256
        String hashedInputPassword = hashPassword(password);
        System.out.println("DEBUG: Hashed input password: " + hashedInputPassword);

        // SQL query to validate admin credentials
        String query = "SELECT password FROM adminusers WHERE LOWER(username) = LOWER(?)";

        try (Connection conn = utils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Retrieve the hashed password stored in the database
                String storedPassword = rs.getString("password");
                System.out.println("DEBUG: Stored password: " + storedPassword);

                // Validate hashed password
                if (storedPassword.equals(hashedInputPassword)) {
                    // Successful login
                    HttpSession session = request.getSession();
                    session.setAttribute("adminUsername", username); // Store username
                    session.setAttribute("role", "admin"); // Add role to session
                    System.out.println("DEBUG: Admin role set in session as 'admin'.");
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    // Invalid password
                    System.out.println("DEBUG: Admin login failed (invalid password)!");
                    request.setAttribute("error", true);
                    request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
                }
            } else {
                // Invalid username
                System.out.println("DEBUG: Admin login failed (invalid username)!");
                request.setAttribute("error", true);
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL exception occurred during admin login.");
            e.printStackTrace();
            request.setAttribute("error", true);
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error while hashing password", e);
        }
    }
}