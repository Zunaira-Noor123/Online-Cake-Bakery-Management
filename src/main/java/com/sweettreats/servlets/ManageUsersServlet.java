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

@WebServlet("/ManageUsersServlet")
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // Handle User Update
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            try (Connection conn = utils.getConnection()) {
                String query = "UPDATE Users SET username = ?, email = ? WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setInt(3, userId);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("DEBUG: User with ID " + userId + " updated successfully.");
                } else {
                    System.out.println("DEBUG: Failed to update user with ID " + userId);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("manageUsers.jsp"); // Redirect back to Manage Users page
        } else if ("delete".equals(action)) {
            // Handle User Deletion
            int userId = Integer.parseInt(request.getParameter("userId"));

            try (Connection conn = utils.getConnection()) {
                String query = "DELETE FROM Users WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, userId);

                int rowsAffected = ps.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("DEBUG: User with ID " + userId + " deleted successfully.");
                } else {
                    System.out.println("DEBUG: Failed to delete user with ID " + userId);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("manageUsers.jsp"); // Redirect back to Manage Users page
        }
    }
}