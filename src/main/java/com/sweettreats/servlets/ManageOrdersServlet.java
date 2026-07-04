package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager; // Add this import to use DriverManager
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ManageOrdersServlet")
public class ManageOrdersServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Handle order deletion
            int orderId = 0;
            try {
                // Extract and validate orderId parameter
                orderId = Integer.parseInt(request.getParameter("orderId"));
                System.out.println("DEBUG: Received orderId = " + orderId);
            } catch (NumberFormatException e) {
                System.out.println("ERROR: Invalid orderId received");
                e.printStackTrace();
                response.sendRedirect("manageOrders.jsp");
                return; // Exit execution if orderId is invalid
            }

            String query = "DELETE FROM Orders WHERE id = ?";
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sweettreatsdb", "root", "zunaira_noor786");
                 PreparedStatement ps = conn.prepareStatement(query)) {

                // Pass the received orderId to the query
                ps.setInt(1, orderId);

                System.out.println("DEBUG: Executing DELETE query for orderId = " + orderId);
                int rowsAffected = ps.executeUpdate();
                System.out.println("DEBUG: Rows affected = " + rowsAffected);

                if (rowsAffected > 0) {
                    System.out.println("DEBUG: Order " + orderId + " deleted successfully.");
                } else {
                    System.out.println("DEBUG: Order " + orderId + " not found in the database.");
                }
            } catch (SQLException e) {
                System.out.println("ERROR: SQL exception occurred while deleting order.");
                e.printStackTrace();
                response.sendRedirect("manageOrders.jsp");
                return; // Exit if database error occurs
            }

            // Redirect back to manageOrders.jsp after processing
            response.sendRedirect("manageOrders.jsp");
        }
    }
}