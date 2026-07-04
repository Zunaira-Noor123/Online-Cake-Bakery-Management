package com.sweettreats.servlets;

import com.sweettreats.dao.CakeDAO;
import com.sweettreats.model.Cake;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CakeManagementServlet")
public class CakeManagementServlet extends HttpServlet {

    private CakeDAO cakeDAO;

    @Override
    public void init() throws ServletException {
        // Initialize CakeDAO for database operations
        cakeDAO = new CakeDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get action parameter to determine operation (add, delete, edit)
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addCake(request, response);
                    break;
                case "delete":
                    deleteCake(request, response);
                    break;
                case "edit":
                    editCake(request, response);
                    break;
                default:
                    response.sendRedirect("manageCakes.jsp?error=unknownAction");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageCakes.jsp?error=serverError");
        }
    }

    /**
     * Add a new cake to the database.
     */
    private void addCake(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve form parameters for the new cake
        String name = request.getParameter("cakeName");
        String description = request.getParameter("cakeDescription");
        double price = Double.parseDouble(request.getParameter("cakePrice"));
        String ingredients = request.getParameter("cakeIngredients");
        String imageUrl = request.getParameter("cakeImage");

        // Create a new Cake object
        Cake newCake = new Cake(0, name, description, price, imageUrl, ingredients);

        // Insert the new cake into the database
        boolean success = cakeDAO.addCake(newCake);

        // Redirect to manageCakes.jsp with success or error
        if (success) {
            response.sendRedirect("manageCakes.jsp?success=cakeAdded");
        } else {
            response.sendRedirect("manageCakes.jsp?error=addCakeFailed");
        }
    }

    /**
     * Edit an existing cake in the database.
     */
    private void editCake(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve form parameters for the cake to edit
        int cakeId = Integer.parseInt(request.getParameter("cakeId"));
        String name = request.getParameter("cakeName");
        String description = request.getParameter("cakeDescription");
        double price = Double.parseDouble(request.getParameter("cakePrice"));
        String ingredients = request.getParameter("cakeIngredients");
        String imageUrl = request.getParameter("cakeImage");

        // Create an updated Cake object
        Cake updatedCake = new Cake(cakeId, name, description, price, imageUrl, ingredients);

        // Update the cake in the database
        boolean success = cakeDAO.updateCake(updatedCake);

        // Redirect to manageCakes.jsp with success or error
        if (success) {
            response.sendRedirect("manageCakes.jsp?success=cakeUpdated");
        } else {
            response.sendRedirect("manageCakes.jsp?error=editCakeFailed");
        }
    }

    /**
     * Delete a cake from the database.
     */
    private void deleteCake(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve the ID of the cake to delete
        int cakeId = Integer.parseInt(request.getParameter("cakeId"));

        // Delete the cake from the database
        boolean success = cakeDAO.deleteCake(cakeId);

        // Redirect back to manageCakes.jsp with success or error
        if (success) {
            response.sendRedirect("manageCakes.jsp?success=cakeDeleted");
        } else {
            response.sendRedirect("manageCakes.jsp?error=deleteCakeFailed");
        }
    }
}