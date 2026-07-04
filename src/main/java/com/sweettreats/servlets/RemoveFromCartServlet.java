package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;
import com.sweettreats.model.Cake;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get cake ID from request
        int cakeId = Integer.parseInt(request.getParameter("cakeId"));

        // Get the user's session
        HttpSession session = request.getSession();
        Map<Cake, Integer> cart = (Map<Cake, Integer>) session.getAttribute("cart");

        if (cart != null) {
            // Find and remove the cake from the cart
            Cake cakeToRemove = null;
            for (Cake cake : cart.keySet()) {
                if (cake.getId() == cakeId) {
                    cakeToRemove = cake;
                    break;
                }
            }
            if (cakeToRemove != null) {
                cart.remove(cakeToRemove);
            }

            // Update cart in session
            session.setAttribute("cart", cart);
        }

        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
}