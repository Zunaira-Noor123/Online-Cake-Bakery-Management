package com.sweettreats.servlets;

import com.sweettreats.utils.utils; // Utility class for database connection, etc.
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

@WebServlet("/DeliveryLoginServlet")
public class DeliveryLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch username and password from the request (sent from the form)
        String username = request.getParameter("username"); // Fetch the 'username'
        String password = request.getParameter("password"); // Fetch the 'password'

        // Debug input to ensure values are received correctly
        System.out.println("DEBUG: Username = " + username + ", Password = " + password);

        // Validate credentials against the database
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT id, name FROM delivery_persons WHERE name = ? AND password = ?"
             )) {
            // Set the username and password as query parameters
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery(); // Execute the query

            if (rs.next()) { 
                // If credentials are valid
                int deliveryPersonId = rs.getInt("id");
                String deliveryPersonName = rs.getString("name");

                // Set session attributes for the delivery person
                HttpSession session = request.getSession();
                session.setAttribute("deliveryId", deliveryPersonId); // Save the unique ID
                session.setAttribute("deliveryPersonName", deliveryPersonName); // Save the name
                session.setAttribute("role", "delivery"); // Set the user role as 'delivery'

                // Debug successful login
                System.out.println("DEBUG: Successful login for delivery person: " + deliveryPersonName);

                // Redirect to the delivery dashboard
                response.sendRedirect("deliveryDashboard.jsp");
            } else {
                // Debug invalid credentials
                System.out.println("DEBUG: Invalid username or password.");

                // Redirect back to the login page with an error message
                response.sendRedirect("deliveryLogin.jsp?error=invalid");
            }
        } catch (SQLException e) {
            // If any database error occurs
            throw new ServletException("Database error during login", e);
        }
    }
}