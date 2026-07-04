package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/DeliveryLogoutServlet")
public class DeliveryLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the current session (if it exists)
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate the current session to log out the user
            session.invalidate();
        }

        // Redirect to the Dashboard.jsp page after logout
        response.sendRedirect("Dashboard.jsp");
    }
}