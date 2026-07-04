package com.sweettreats.servlets;

import com.sweettreats.dao.DeliveryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Delivery Management Servlet for assigning delivery person and updating delivery status.
 */
@WebServlet("/DeliveryManagementServlet")
public class DeliveryManagementServlet extends HttpServlet {

    private DeliveryDAO deliveryDAO;

    private static final String SUCCESS_ASSIGN = "manageDeliveries.jsp?success=assigned";
    private static final String SUCCESS_STATUS = "manageDeliveries.jsp?success=statusUpdated";
    private static final String ERROR_GENERIC = "manageDeliveries.jsp?error=serverError";
    private static final String ERROR_INVALID_INPUT = "manageDeliveries.jsp?error=invalidInput";
    private static final String ERROR_INVALID_PERSON = "manageDeliveries.jsp?error=invalidDeliveryPerson";
    private static final String ERROR_NO_STATUS = "manageDeliveries.jsp?error=noStatusProvided";
    private static final String ERROR_UNKNOWN_ACTION = "manageDeliveries.jsp?error=unknownAction";

    @Override
    public void init() throws ServletException {
        deliveryDAO = new DeliveryDAO(); // Initialize the DAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("assign".equals(action)) {
                assignDeliveryPerson(request, response);
            } else if ("updateStatus".equals(action)) {
                updateDeliveryStatus(request, response);
            } else {
                response.sendRedirect(ERROR_UNKNOWN_ACTION);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(ERROR_GENERIC);
        }
    }

    /**
     * Assign a delivery person to a delivery.
     */
    /**
 * Assign a delivery person to a delivery.
 * If no deliveryPersonId is provided, unset (unassign) the delivery.
 */
private void assignDeliveryPerson(HttpServletRequest request, HttpServletResponse response) throws IOException {
    try {
        int deliveryId = Integer.parseInt(request.getParameter("deliveryId"));
        String deliveryPersonId = request.getParameter("deliveryPersonId");

        if (deliveryPersonId == null || deliveryPersonId.isEmpty()) {
            // Handle case of unassignment
            System.out.println("DEBUG: No delivery person ID provided. Unassigning delivery.");
            boolean success = deliveryDAO.assignDeliveryPerson(deliveryId, null); // Unassign
            if (success) {
                System.out.println("DEBUG: Delivery unassigned successfully (deliveryId: " + deliveryId + ").");
                response.sendRedirect(SUCCESS_ASSIGN);
            } else {
                System.out.println("DEBUG: Failed to unassign delivery.");
                response.sendRedirect(ERROR_GENERIC);
            }
            return;
        }

        // Validate delivery person and assign
        if (!deliveryDAO.isValidDeliveryPerson(deliveryPersonId)) {
            System.out.println("DEBUG: Invalid delivery person ID.");
            response.sendRedirect(ERROR_INVALID_PERSON);
            return;
        }

        boolean success = deliveryDAO.assignDeliveryPerson(deliveryId, Integer.parseInt(deliveryPersonId));
        if (success) {
            System.out.println("DEBUG: Delivery person assigned successfully (deliveryId: " + deliveryId + ").");
            response.sendRedirect(SUCCESS_ASSIGN);
        } else {
            System.out.println("DEBUG: Failed to assign delivery person.");
            response.sendRedirect(ERROR_GENERIC);
        }
    } catch (NumberFormatException e) {
        System.out.println("DEBUG: Invalid input format.");
        e.printStackTrace();
        response.sendRedirect(ERROR_INVALID_INPUT);
    }
}

    /**
     * Update the status of a delivery.
     */
    private void updateDeliveryStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int deliveryId = Integer.parseInt(request.getParameter("deliveryId"));
            String status = request.getParameter("status");

            if (status == null || status.isEmpty()) {
                System.out.println("DEBUG: No status provided.");
                response.sendRedirect(ERROR_NO_STATUS);
                return;
            }

            boolean success = deliveryDAO.updateDeliveryStatus(deliveryId, status);
            if (success) {
                System.out.println("DEBUG: Delivery status updated successfully (deliveryId: " + deliveryId + ").");
                response.sendRedirect(SUCCESS_STATUS);
            } else {
                System.out.println("DEBUG: Failed to update delivery status.");
                response.sendRedirect(ERROR_GENERIC);
            }
        } catch (NumberFormatException e) {
            System.out.println("DEBUG: Invalid input format.");
            e.printStackTrace();
            response.sendRedirect(ERROR_INVALID_INPUT);
        }
    }
}