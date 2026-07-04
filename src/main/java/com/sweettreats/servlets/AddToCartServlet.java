package com.sweettreats.servlets;

import com.sweettreats.dao.CakeDAO;
import com.sweettreats.model.Cake;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    private CakeDAO cakeDAO;

    @Override
    public void init() {
        // Initialize CakeDAO for database operations
        cakeDAO = new CakeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Use shared logic for POST
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Use shared logic for GET
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve and validate the cakeId parameter
        String cakeIdParam = request.getParameter("cakeId");
        System.out.println("DEBUG: cakeIdParam received: " + cakeIdParam);

        int cakeId;
        try {
            if (cakeIdParam == null || !cakeIdParam.matches("\\d+")) {
                System.out.println("DEBUG: Invalid cakeIdParam!");
                response.sendRedirect("cakes.jsp?error=invalidCake");
                return;
            }
            cakeId = Integer.parseInt(cakeIdParam);
        } catch (NumberFormatException e) {
            System.out.println("DEBUG: NumberFormatException for cakeIdParam: " + cakeIdParam);
            response.sendRedirect("cakes.jsp?error=invalidCake");
            return;
        }

        System.out.println("DEBUG: cakeId parsed successfully: " + cakeId);

        // Fetch the cake details
        Cake cake = cakeDAO.getCakeById(cakeId);
        if (cake == null) {
            System.out.println("DEBUG: Cake not found with cakeId: " + cakeId);
            response.sendRedirect("cakes.jsp?error=cakeNotFound");
            return;
        }
        System.out.println("DEBUG: Cake found: " + cake.getName());

        // Retrieve or initialize the session's cart
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        Map<Cake, Integer> cart = (Map<Cake, Integer>) session.getAttribute("cart");
        if (cart == null) {
            System.out.println("DEBUG: Initializing a new cart.");
            cart = new HashMap<>();
        }

        // Add or update the cake in the cart
        if (cart.containsKey(cake)) {
            cart.put(cake, cart.get(cake) + 1); // Increment quantity
            System.out.println("DEBUG: Incremented quantity for cake: " + cake.getName());
        } else {
            cart.put(cake, 1); // Add as new item
            System.out.println("DEBUG: Added new cake to cart: " + cake.getName());
        }

        // Save the updated cart in the session
        session.setAttribute("cart", cart);

        // Redirect to cart.jsp
        System.out.println("DEBUG: Redirecting to cart.jsp");
        response.sendRedirect("cart.jsp");
    }
}