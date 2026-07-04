package com.sweettreats.servlets;

import com.sweettreats.model.Delivery;
import com.sweettreats.utils.utils;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ViewPendingDeliveriesServlet")
public class ViewPendingDeliveriesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the delivery person's ID from their session
        HttpSession session = request.getSession();
        Integer deliveryPersonId = (Integer) session.getAttribute("deliveryId");

        // Debugging: Print deliveryId
        System.out.println("DEBUG: Retrieved deliveryId from session: " + deliveryPersonId);

        // If deliveryPersonId is null, redirect to login
        if (deliveryPersonId == null) {
            response.sendRedirect("deliveryLogin.jsp");
            return;
        }

        // SQL query to fetch pending deliveries
        String query = "SELECT * FROM deliveries WHERE delivery_person_id = ? AND status = 'pending'";

        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, deliveryPersonId); // Set deliveryId in the query
            ResultSet rs = ps.executeQuery();

            // Process the result set
            List<Delivery> pendingDeliveries = new ArrayList<>();
            while (rs.next()) {
                Delivery delivery = new Delivery(
                    rs.getInt("id"),
                    rs.getInt("order_id"),
                    rs.getInt("delivery_person_id"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at"),
                    rs.getTimestamp("updated_at")
                );
                pendingDeliveries.add(delivery);

                // Debugging: Print each row
                System.out.println("DEBUG: Delivery fetched - ID: " + delivery.getId()
                    + ", OrderID: " + delivery.getOrderId());
            }

            // Debugging: Total deliveries fetched
            System.out.println("DEBUG: Total pending deliveries: " + pendingDeliveries.size());

            // Set the pending deliveries as a request attribute and forward to viewPendingDeliveries.jsp
            request.setAttribute("pendingDeliveries", pendingDeliveries);
            request.getRequestDispatcher("viewPendingDeliveries.jsp").forward(request, response);

        } catch (SQLException e) {
            System.out.println("ERROR: Database query failed: " + e.getMessage());
            throw new ServletException("Database error while fetching deliveries", e);
        }
    }
}