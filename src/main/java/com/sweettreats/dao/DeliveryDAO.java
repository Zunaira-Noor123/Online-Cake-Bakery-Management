package com.sweettreats.dao;

import com.sweettreats.model.Delivery;
import com.sweettreats.model.DeliveryPerson; // Import DeliveryPerson model
import com.sweettreats.utils.utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO {

    private static final String SELECT_ALL_DELIVERIES = "SELECT * FROM deliveries";
    private static final String UPDATE_DELIVERY_PERSON = "UPDATE deliveries SET delivery_person_id = ? WHERE id = ?";
    private static final String UPDATE_DELIVERY_STATUS = "UPDATE deliveries SET status = ?, updated_at = NOW() WHERE id = ?";
    private static final String SELECT_ALL_DELIVERY_PERSONS = "SELECT id, name, email FROM delivery_persons";
    private static final String VALID_DELIVERY_PERSON_QUERY = "SELECT id FROM delivery_persons WHERE id = ?";

    /**
     * Fetch all deliveries from the database
     */
    public List<Delivery> getAllDeliveries() {
        List<Delivery> deliveries = new ArrayList<>();

        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_DELIVERIES)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                deliveries.add(new Delivery(
                        rs.getInt("id"),
                        rs.getInt("order_id"),
                        rs.getObject("delivery_person_id", Integer.class), // Handle nullable delivery_person_id
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deliveries;
    }

    /**
     * Assign a delivery person to a delivery.
     */
    /**
 * Assign a delivery person to a delivery.
 * If deliveryPersonId is null, unassign the delivery.
 */
public boolean assignDeliveryPerson(int deliveryId, Integer deliveryPersonId) {
    String query = "UPDATE deliveries SET delivery_person_id = ? WHERE id = ?";
    try (Connection conn = utils.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        if (deliveryPersonId == null) {
            ps.setNull(1, java.sql.Types.INTEGER); // Set delivery_person_id to NULL (unassigned)
        } else {
            ps.setInt(1, deliveryPersonId); // Assign delivery person ID
        }
        ps.setInt(2, deliveryId);

        return ps.executeUpdate() > 0; // Returns true if row is updated
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    /**
     * Update the status of a delivery.
     */
    public boolean updateDeliveryStatus(int deliveryId, String status) {
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_DELIVERY_STATUS)) {

            ps.setString(1, status);
            ps.setInt(2, deliveryId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Fetch all delivery persons from the delivery_persons table.
     */
    public List<DeliveryPerson> getAllDeliveryPersons() {
        List<DeliveryPerson> deliveryPersons = new ArrayList<>();

        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_DELIVERY_PERSONS)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                deliveryPersons.add(new DeliveryPerson(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        null // Created_at omitted for this query
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deliveryPersons;
    }

    /**
     * Validate if a delivery person exists in the database.
     */
    /**
 * Validate if a delivery person exists in the database.
 * Return true if the ID is valid or null (for unassignment).
 */
public boolean isValidDeliveryPerson(String deliveryPersonId) {
    if (deliveryPersonId == null || deliveryPersonId.isEmpty()) {
        return true; // Allow unassigned delivery (null as valid)
    }

    String query = "SELECT id FROM delivery_persons WHERE id = ?";
    try (Connection conn = utils.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, Integer.parseInt(deliveryPersonId)); // Check if ID exists
        ResultSet rs = ps.executeQuery();

        return rs.next(); // True if delivery person exists
    } catch (SQLException | NumberFormatException e) {
        e.printStackTrace();
        return false;
    }
}
    /**
 * Assign a delivery person to a delivery.
 * If deliveryPersonId is null, unassign the delivery.
 */

}