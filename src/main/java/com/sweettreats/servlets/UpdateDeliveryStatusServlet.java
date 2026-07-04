package com.sweettreats.servlets;

import com.sweettreats.utils.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UpdateDeliveryStatusServlet")
public class UpdateDeliveryStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve parameters from the form
        int deliveryId = Integer.parseInt(request.getParameter("deliveryId").trim());
        String newStatus = request.getParameter("status").trim();

        // SQL query to update delivery status
        String query = "UPDATE deliveries SET status = ?, updated_at = NOW() WHERE id = ?";

        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, newStatus); // Set the new status
            ps.setInt(2, deliveryId);   // Set the ID of the delivery to update

            int updatedRows = ps.executeUpdate();

            if (updatedRows > 0) {
                // Success: Redirect to the view pending deliveries page
                response.sendRedirect("ViewPendingDeliveriesServlet");
            } else {
                // Failure: Redirect with an error message
                response.sendRedirect("viewPendingDeliveries.jsp?error=update_failed");
            }

        } catch (SQLException e) {
            throw new ServletException("Database error while updating delivery status", e);
        }
    }
}