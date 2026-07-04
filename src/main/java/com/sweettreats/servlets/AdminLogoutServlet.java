package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/AdminLogoutServlet")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get admin session
        HttpSession session = request.getSession(false); // Fetch session if it exists

        if (session != null) {
            // Retrieve adminUsername for logging
            Object adminUsername = session.getAttribute("adminUsername");
            if (adminUsername != null) {
                System.out.println("DEBUG: Admin '" + adminUsername + "' is logging out at " + LocalDateTime.now());
            } else {
                System.out.println("DEBUG: Admin session invalidated without username at " + LocalDateTime.now());
            }

            // Invalidate the session
            session.invalidate();
            System.out.println("DEBUG: Admin logged out successfully.");
        } else {
            System.out.println("DEBUG: No session found. Redirecting to login.");
        }

        // Redirect to admin login page with a success message
        response.sendRedirect("Dashboard.jsp?success=logout");
    }
}