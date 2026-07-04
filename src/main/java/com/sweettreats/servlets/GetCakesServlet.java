/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sweettreats.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.sweettreats.dao.CakeDAO;
import com.sweettreats.model.Cake;

@WebServlet("/get-cakes")
public class GetCakesServlet extends HttpServlet {

    private CakeDAO cakeDAO;

    @Override
    public void init() {
        // Initialize CakeDAO for database interaction
        cakeDAO = new CakeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch cakes from the database using CakeDAO
        List<Cake> cakes = cakeDAO.getAllCakes();

        // Pass cakes list to JSP through the request
        request.setAttribute("cakes", cakes);

        // Forward the request to cakes.jsp for rendering
        request.getRequestDispatcher("/cakes.jsp").forward(request, response);
    }
}