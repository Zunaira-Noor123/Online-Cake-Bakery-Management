package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.sweettreats.dao.CakeDAO;
import com.sweettreats.model.Cake;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final String INSERT_ORDER = "INSERT INTO Orders (user_id, total_price) VALUES (?, ?)";
    private static final String INSERT_ORDER_ITEM = "INSERT INTO OrderItems (order_id, cake_id, quantity, price) VALUES (?, ?, ?, ?)";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Map<Cake, Integer> cart = (Map<Cake, Integer>) session.getAttribute("cart");
        Integer userId = (Integer) session.getAttribute("userId");

        if (cart == null || cart.isEmpty() || userId == null) {
            System.out.println("DEBUG: Cart is empty or user is not logged in.");
            response.sendRedirect("cart.jsp");
            return;
        }

        double totalPrice = 0.0;
        for (Map.Entry<Cake, Integer> entry : cart.entrySet()) {
            Cake cake = entry.getKey();
            Integer quantity = entry.getValue();
            totalPrice += cake.getPrice() * quantity;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sweettreatsdb", "root", "zunaira_noor786")) {
            conn.setAutoCommit(false); // Start transaction
            try {
                // Insert order and retrieve generated order ID
                PreparedStatement psOrder = conn.prepareStatement(INSERT_ORDER, PreparedStatement.RETURN_GENERATED_KEYS);
                psOrder.setInt(1, userId);
                psOrder.setDouble(2, totalPrice);
                psOrder.executeUpdate();
                ResultSet rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    int orderId = rs.getInt(1);
                    System.out.println("DEBUG: Generated orderId = " + orderId);

                    // Insert order items
                    PreparedStatement psOrderItem = conn.prepareStatement(INSERT_ORDER_ITEM);
                    for (Map.Entry<Cake, Integer> entry : cart.entrySet()) {
                        Cake cake = entry.getKey();
                        Integer quantity = entry.getValue();

                        psOrderItem.setInt(1, orderId);
                        psOrderItem.setInt(2, cake.getId());
                        psOrderItem.setInt(3, quantity);
                        psOrderItem.setDouble(4, cake.getPrice());
                        System.out.println("DEBUG: Inserting order item - OrderId: " + orderId + ", CakeId: " + cake.getId() + 
                                           ", Quantity: " + quantity + ", Price: " + cake.getPrice());
                        psOrderItem.addBatch();
                    }
                    psOrderItem.executeBatch();
                } else {
                    System.out.println("ERROR: Failed to retrieve generated orderId.");
                    conn.rollback();
                    response.sendRedirect("cart.jsp?error=order_id_failed");
                    return;
                }

                conn.commit(); // Commit transaction
                session.removeAttribute("cart"); // Clear cart
                response.sendRedirect("order_history.jsp"); // Redirect to order history
            } catch (Exception e) {
                conn.rollback(); // Rollback on error
                System.out.println("ERROR: Transaction rolled back due to exception - " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("cart.jsp?error=checkout_failed");
            }
        } catch (SQLException e) {
            System.out.println("ERROR: Database connection failed - " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=database_error");
        }
    }
}