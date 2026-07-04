package com.sweettreats.servlets;

import com.sweettreats.dao.CakeDAO;
import com.sweettreats.model.Cake;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CakeDetailsServlet")
public class CakeDetailsServlet extends HttpServlet {

    private CakeDAO cakeDAO;

    @Override
    public void init() {
        // Instantiate CakeDAO (initialize it for database operations)
        cakeDAO = new CakeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get cakeId from request parameters
        String cakeIdParam = request.getParameter("cakeId");

        if (cakeIdParam != null) {
            int cakeId = Integer.parseInt(cakeIdParam);

            // Get cake details using CakeDAO
            Cake cake = cakeDAO.getCakeById(cakeId); // Method should return Cake by ID

            if (cake != null) {
                // Pass cake attributes to the request
                request.setAttribute("cakeName", cake.getName());
                request.setAttribute("cakeDescription", cake.getDescription());
                request.setAttribute("cakePrice", cake.getPrice());
                request.setAttribute("cakeIngredients", cake.getIngredients());
                request.setAttribute("cakeImage", cake.getImageUrl());

                // Forward to cakeDetails.jsp
                request.getRequestDispatcher("cakeDetails.jsp").forward(request, response);
            } else {
                // Redirect back if no cake found
                response.sendRedirect("cakes.jsp?error=cakeNotFound");
            }
        } else {
            // Redirect back if no cakeId provided
            response.sendRedirect("cakes.jsp");
        }
    }
}