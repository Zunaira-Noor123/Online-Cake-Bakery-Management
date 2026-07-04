package com.sweettreats.dao;

import com.sweettreats.model.Cake;
import com.sweettreats.utils.utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CakeDAO {

    // Query Constants
    private static final String SELECT_ALL_CAKES = "SELECT id, name, description, price, imageUrl, ingredients FROM Cakes";
    private static final String SELECT_CAKE_BY_ID = "SELECT id, name, description, price, imageUrl, ingredients FROM Cakes WHERE id = ?";
    private static final String INSERT_CAKE = "INSERT INTO Cakes (name, description, price, imageUrl, ingredients) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_CAKE = "UPDATE Cakes SET name = ?, description = ?, price = ?, imageUrl = ?, ingredients = ? WHERE id = ?";
    private static final String DELETE_CAKE = "DELETE FROM Cakes WHERE id = ?";
    private static final String COUNT_CAKES = "SELECT COUNT(*) AS count FROM Cakes";

    /**
     * Fetch all cakes from the database dynamically.
     *
     * @return List of Cake objects
     */
    public List<Cake> getAllCakes() {
        List<Cake> cakes = new ArrayList<>();
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_CAKES);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("Fetching all cakes...");
            while (rs.next()) {
                cakes.add(new Cake(
                        rs.getInt("id"), 
                        rs.getString("name"), 
                        rs.getString("description"), 
                        rs.getDouble("price"), 
                        rs.getString("imageUrl"), 
                        rs.getString("ingredients")
                ));
            }
            System.out.println(cakes.size() + " cakes fetched successfully.");

        } catch (SQLException e) {
            System.out.println("Error fetching cakes.");
            e.printStackTrace();
        }
        return cakes;
    }

    /**
     * Fetch a single cake by its ID.
     *
     * @param id Cake ID
     * @return Cake object or null if not found
     */
    public Cake getCakeById(int id) {
        Cake cake = null;
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CAKE_BY_ID)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                cake = new Cake(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("imageUrl"),
                        rs.getString("ingredients")
                );
                System.out.println("Cake fetched: " + cake.getName());
            } else {
                System.out.println("No cake found with ID: " + id);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching the cake with ID: " + id);
            e.printStackTrace();
        }
        return cake;
    }

    /**
     * Add a new cake to the database.
     *
     * @param cake Cake object
     * @return True if the insertion was successful, false otherwise
     */
    public boolean addCake(Cake cake) {
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_CAKE)) {

            ps.setString(1, cake.getName());
            ps.setString(2, cake.getDescription());
            ps.setDouble(3, cake.getPrice());
            ps.setString(4, cake.getImageUrl());
            ps.setString(5, cake.getIngredients());

            int rowsInserted = ps.executeUpdate();
            System.out.println("Cake added successfully. Rows inserted: " + rowsInserted);
            return rowsInserted > 0;

        } catch (SQLException e) {
            System.out.println("Error adding the cake.");
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Update an existing cake in the database.
     *
     * @param cake Cake object (with ID for update)
     * @return True if the update was successful, false otherwise
     */
    public boolean updateCake(Cake cake) {
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_CAKE)) {

            ps.setString(1, cake.getName());
            ps.setString(2, cake.getDescription());
            ps.setDouble(3, cake.getPrice());
            ps.setString(4, cake.getImageUrl());
            ps.setString(5, cake.getIngredients());
            ps.setInt(6, cake.getId());

            int rowsUpdated = ps.executeUpdate();
            System.out.println("Cake updated successfully. Rows updated: " + rowsUpdated);
            return rowsUpdated > 0;

        } catch (SQLException e) {
            System.out.println("Error updating the cake with ID: " + cake.getId());
            e.printStackTrace();
        }
        return false;
    }
        /**
     * Search cakes by name or description.
     *
     * @param keyword text to search
     * @return list of matching cakes
     */
    public List<Cake> searchCakes(String keyword) {
        List<Cake> cakes = new ArrayList<>();

        String SEARCH_CAKES =
                "SELECT id, name, description, price, imageUrl, ingredients " +
                "FROM Cakes WHERE name LIKE ? OR description LIKE ?";

        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(SEARCH_CAKES)) {

            String value = "%" + keyword + "%";
            ps.setString(1, value);
            ps.setString(2, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                cakes.add(new Cake(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("imageUrl"),
                        rs.getString("ingredients")
                ));
            }

            System.out.println("Search keyword: " + keyword + 
                               " | Results: " + cakes.size());

        } catch (SQLException e) {
            System.out.println("Error while searching cakes.");
            e.printStackTrace();
        }

        return cakes;
    }


    /**
     * Delete a cake by its ID.
     *
     * @param cakeId Cake ID
     * @return True if the deletion was successful, false otherwise
     */
    public boolean deleteCake(int cakeId) {
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_CAKE)) {

            ps.setInt(1, cakeId);

            int rowsDeleted = ps.executeUpdate();
            System.out.println("Cake deleted successfully. Rows deleted: " + rowsDeleted);
            return rowsDeleted > 0;

        } catch (SQLException e) {
            System.out.println("Error deleting the cake with ID: " + cakeId);
            e.printStackTrace();
        }
        return false;
    }
    public List<Cake> getCakesByPrice(double minPrice, double maxPrice) {
    List<Cake> cakes = new ArrayList<>();
    String sql = "SELECT id, name, description, price, imageUrl, ingredients FROM Cakes WHERE price BETWEEN ? AND ?";

    try (Connection conn = utils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setDouble(1, minPrice);
        ps.setDouble(2, maxPrice);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            cakes.add(new Cake(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getString("imageUrl"),
                rs.getString("ingredients")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return cakes;
}


    /**
     * Count the total number of cakes in the database.
     *
     * @return Total number of cakes
     */
    public int countCakes() {
        int count = 0;
        try (Connection conn = utils.getConnection();
             PreparedStatement ps = conn.prepareStatement(COUNT_CAKES);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("count");
                System.out.println("Total number of cakes in the database: " + count);
            }

        } catch (SQLException e) {
            System.out.println("Error counting cakes.");
            e.printStackTrace();
        }
        return count;
    }
}